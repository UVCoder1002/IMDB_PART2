//
//  MovieListViewControllerExtension.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 29/08/23.
//

import Foundation


extension MovieListViewController: MovieListDataProviderProtocol{
    
    
    var id: Int {
        get {
            return viewId
        }
        set {
            viewId = newValue
        }
    }
    
    
     func initDataProvider() {
        self.movieListModel = ViewModel(movieList: [:])
        print("DEBUG: inside initdataprovider")
        self.movieListModel?.movieList.addObserver(self) { updatedMovieListViewModel in
            DispatchQueue.main.async {
                self.movieListView.reloadData()
            }
            
            
        }
        self.movieListModel?.getMovieList(from: Constants.fetchMovieListURLString + currentPage.description)


    }
    
}
