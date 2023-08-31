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
    var movieListModel : ViewModel?
    private var selectedMovie : Movie?
    var currentPage = 1
    var viewId = 111
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListModel?.movieList.value.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.movieListViewCellId, for: indexPath) as? MovieListCell
        {
            if let dict = movieListModel?.movieList.value

            {
                let array = [Movie](dict.values)
                cell.configureCell(from: array[indexPath.row])
                return cell
            }
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    override func viewDidLoad() {

        super.viewDidLoad()
        movieListView.delegate = self
        movieListView.dataSource = self
        
       initDataProvider()
        // Do any additional setup after loading the view.
    }
    
   
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        print("DEBUG: \(movieList?[indexPath.row])")
        if let movieList = movieListModel?.movieList{
            let array = Array(movieList.value.values)
            selectedMovie = array[indexPath.row]
        }
        print("DEBUG: selectedmovie \(selectedMovie)")
        performSegue(withIdentifier: "ToMovieDetailsPage", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == movieListModel?.movieList.value.count{
        
            currentPage = currentPage + 1
            print("current page: \(currentPage)")
            movieListModel?.getMovieList(from: Constants.fetchMovieListURLString + currentPage.description)
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

