//
//  MovieListDataProvider.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 28/08/23.
//

import Foundation





class MovieListDataProvider : DataProviderManager<MovieListDataProviderProtocol,Movie>{
     var movieList : [Movie]?

    func getMovieList(pageNo page: Int) {
        
        Task {
            await MovieListRepository.shared.getMovieList(from: Constants.fetchMovieListURLString + page.description , completionBlock: { movieList,error in
                DispatchQueue.main.async {
                    self.notifyDelegates(model: movieList, error: error)
                }
                
            })
        }
        
    }
    
    override func addDelegate(observer: MovieListDataProviderProtocol) {
        if self.delegate == nil{
            self.delegate = [MovieListDataProviderProtocol]()
        }
        self.delegate?.append(observer)
    }
    
    override func notifyDelegates(model: [Movie]?, error: Error?) {
        if let delegates = self.delegate {
            for delegate in delegates{
                if let error = error{
                    delegate.onError(error: error)
                }
                if let movieList = model{
                    delegate.onSuccess(model: movieList)
                }
            }
        }
        
    }
    
}
