//
//  MovieListCell.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 26/08/23.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    
    
    func configureCell(from movie: Movie) {
        movieTitleLabel.text = movie.title
        movieOverviewLabel.text = movie.overview
        if let posterImage = movie.posterImage{
            posterImageView.image = UIImage(data: posterImage)
            posterImageView.layer.cornerRadius = 10
            posterImageView.clipsToBounds = true
            posterImageView.tintColor = UIColor.black
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
