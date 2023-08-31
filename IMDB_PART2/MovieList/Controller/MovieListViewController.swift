//
//  MovieListViewController.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 26/08/23.
//

import UIKit

class MovieListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var movieListView: UITableView!
    var movielistDataProvider : MovieListDataProvider?
    var movieList : [Int64 : Movie]?
    @objc var movieListViewModel = ViewModel()
    private var selectedMovie : Movie?
    private var isNewPage :  Bool?
    private var currentPage = 1
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieListViewCellId,for: indexPath) as? MovieListCell{
            if let movieList = movieList{
                 let array = Array(movieList.values)[indexPath.row]
                    cell.configureCell(from: array)
                
            }
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func viewDidLoad() {
        isNewPage = true
        super.viewDidLoad()
        movieListView.delegate = self
        movieListView.dataSource = self
        
       initDataProvider()
        // Do any additional setup after loading the view.
    }
    
    private func initDataProvider() {
        print("DEBUG: inside initdataprovider")
        self.movielistDataProvider = MovieListDataProvider()
        self.movielistDataProvider?.addDelegate(observer: self)
        self.movielistDataProvider?.getMovieList(pageNo: currentPage)
       
    
        

    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print("DEBUG: \(movieList?[indexPath.row])")
        if let movieList = movieList{
            let array = Array(movieList.values)[indexPath.row]
            selectedMovie = array
        }
        print("DEBUG: selectedmovie \(selectedMovie)")
        performSegue(withIdentifier: "ToMovieDetailsPage", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == movieList?.count{
            isNewPage = true
            currentPage = currentPage + 1
            print("current page: \(currentPage)")
            self.movielistDataProvider?.getMovieList(pageNo: currentPage)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let movieDetailsViewController = segue.destination as? MovieDetailsViewController
        movieDetailsViewController?.movie = selectedMovie
    }
    
    
}

