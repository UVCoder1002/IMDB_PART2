//
//  MovieDetailsViewController.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 26/08/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    //POSTERIMAGEVIEW
    @IBOutlet weak var posterImageView: UIImageView!
    
    //RELEASE DATE
    @IBOutlet weak var releaseDateTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    //RATING
    @IBOutlet weak var ratingTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    //POPULARITY
    @IBOutlet weak var popularityTitleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    //OVERVIEW
    @IBOutlet weak var overViewLabel: UILabel!
    @IBOutlet weak var overViewDescLabel: UILabel!
    var movie : Movie?
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     if let selectedMovie = movie
        {
         print("DEBUG: hii \(selectedMovie)")
         configureTitles()
         configurePage(from: selectedMovie)
     }

        // Do any additional setup after loading the view.
    }
    
    func configureTitles(){
        releaseDateTitleLabel.text = "Release Date"
        ratingTitleLabel.text = "⭐️ Rating       "
        popularityTitleLabel.text = "❤️ Popularity"
        overViewLabel.text = "Overview"
    }
    
    func configurePage(from movie:Movie){
        print("DEBUG: HIII")
        if let posterImage = movie.posterImage{
            posterImageView.image = UIImage(data: posterImage)
            posterImageView.layer.cornerRadius = 20
        }
        releaseDateLabel.text = movie.releaseDate
        ratingLabel.text = movie.voteAverage.description
        popularityLabel.text = movie.popularity.description
        overViewDescLabel.text = movie.overview
        navigationBar.topItem?.title = movie.title
        navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self , action: #selector(dismissPage))
    }
    
   @objc func dismissPage(){
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
