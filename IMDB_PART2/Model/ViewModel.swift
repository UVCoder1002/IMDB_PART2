//
//  ViewModel.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 29/08/23.
//

import Foundation


@objc class ViewModel: NSObject{
    
    var movieList : DataProviderManager<[Int64 : Movie]>
    
    init(movieList : [Int64:Movie]){
        self.movieList = DataProviderManager(value: movieList)
    }
    
    func getMovieList(from url: String) {
        Task{
            await URLService.shared.fetchMovieList(from: url) { movieList,error in
                if let error = error {
                
                    print("Error In Fetching GetMovieList \(error.localizedDescription)")
                }
                if let movieList = movieList{
                    
                    for movie in movieList{
                        self.movieList.value[movie.id] = movie
                        let posterURL = URLService.shared.posterImageURL(from: movie.posterPath)
                        URLService.shared.downloadImg(InputUrl: posterURL) { data in
                            self.movieList.value[movie.id]?.posterImage = data
                        
                        }
                    }
    
                }
            }
        }
    }
}
