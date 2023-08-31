//
//  MovieList.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 28/08/23.
//

import Foundation


protocol movieListRepoProtocol : DataProvider{
    
}
class MovieListRepository{
    
   
     var movieList : [Int64 : Movie]?
    
    private init(){
        
    }
    
    static var shared : MovieListRepository{
        let instance = MovieListRepository()
        return instance
    }
    
    func getMovieList(from url: String,completionBlock: @escaping ([Movie]?,Error?) ->Void) async{
        await URLService.shared.fetchMovieList(from: url) { movieList,error in
            if let error = error {
                completionBlock(nil,error)
            }
            if let movieList = movieList{

                for movie in movieList{
                    self.movieList?[movie.id] = movie
                    let posterURL = URLService.shared.posterImageURL(from: movie.posterPath)
                    URLService.shared.downloadImg(InputUrl: posterURL) { data in
                        self.movieList?[movie.id]?.posterImage = data
                        movie.posterImage = data
                        completionBlock(movieList,nil)
                    }
                }
                completionBlock(movieList,nil)
            }
            }
    }
}
