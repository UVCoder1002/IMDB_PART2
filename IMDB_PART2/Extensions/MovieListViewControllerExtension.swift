//
//  MovieListViewControllerExtension.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 29/08/23.
//

import Foundation


extension MovieListViewController: MovieListDataProviderProtocol{
    func onSuccess(model: Any) {
        if let movieList = model as? [Movie] {
            for movie in movieList {
                if self.movieList == nil {
                    self.movieList = [:]
                }
                self.movieList?[movie.id] = movie
            }
        }
            self.movieListView.reloadData()
        }
    
    
    func onError(error: Error) {
        print("DEBUG: Error \(error.localizedDescription)")
    }
    
    
}
