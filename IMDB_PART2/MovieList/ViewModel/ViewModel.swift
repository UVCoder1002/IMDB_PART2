//
//  ViewModel.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 29/08/23.
//

import Foundation


@objc class ViewModel: NSObject{
    
    var movieList : DataProviderManager<[Int64 : MovieListable]>
    var filteredList : DataProviderManager<[MovieListable]>?
    var movieListURLService = URLService(responseHandler: ResponseHandler<Movies>())
    var isPaginating = false
    var isLoading = false
    init(movieList : [Int64:MovieListable],filteredList : [MovieListable]){
        self.movieList = DataProviderManager(value: movieList)
        self.filteredList = DataProviderManager(value: filteredList)
    }
    
    func getMovieList(from url: String,pagination isPaginating : Bool, completionBlock: @escaping () -> Void) {
        
        self.isLoading = true
        if isPaginating{
            self.isPaginating = true
        }
        Task{
            
            await movieListURLService.handleURLRequest(from: url,parse: true) { movieList,error in
                if let error = error {
                
                    print("Error In Fetching GetMovieList \(error.localizedDescription)")
                }
                if let movieList = movieList as? Movies{
                    
                    for movie in movieList.results{
                        self.movieList.value[movie.id] = movie as any MovieListable
                        let posterURL = self.movieListURLService.posterImageURL(from: movie.posterPath ?? "")
                        Task{
                            
                            await self.movieListURLService.handleURLRequest(from: posterURL,parse: false) { data , error in
                                    if let error = error {
                                        print("Error in fetching image : \(error.localizedDescription)")
                                    }
                                    else{
//                                        self.movieList.value[movie.id]?.posterImage = data as? Data
//                                        self.movieList.secondValue?[movie.id] = data as? Data
                                        movie.posterImage = data as? Data
//                                        self.movieList.value.removeValue(forKey: movie.id)
                                        self.movieList.value.updateValue(movie, forKey: movie.id)
                                    }
                                    
                                
                            }
                        }
                    }
    
                }
                self.isLoading = false
                self.isPaginating = false
                completionBlock()
            }
        }
    }
    
    func searchMovie(searchText text : String) {
        print("DEBUG: function called text: \(text)")
        self.filteredList?.value = []
        let moviesList = Array(movieList.value.values)
        let filteredList = moviesList.filter {
            $0.title?.contains(text) ?? false
        }
        
        self.filteredList?.value = filteredList
        for movie in filteredList{
            print("DEBUG: \(movie.title)")
        }
    }
    
}
