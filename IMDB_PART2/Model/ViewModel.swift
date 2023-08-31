//
//  ViewModel.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 29/08/23.
//

import Foundation


@objc class ViewModel: NSObject{
    
    @objc dynamic var movieList : [Movie]?
    
    @objc func getMovieList(pageNo page: Int) {
        
        Task {
            await MovieListRepository.shared.getMovieList(from: Constants.fetchMovieListURLString + page.description , completionBlock: { movieList,error in
                DispatchQueue.main.async {
                    print("DEBUG: INSIDE GETMOVIELIST(VIEWMODEL)")
                    self.movieList = movieList
            }
                
            })
        }
        
    }
    func update(){
        if movieList == nil{
            movieList = [Movie]()
        }
        movieList?.append(Movie.MOCK_MOVIE)
    }
}
