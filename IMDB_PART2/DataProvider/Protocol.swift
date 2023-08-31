//
//  Protocol.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 28/08/23.
//

import Foundation


protocol DataProvider {
    
    func onSuccess(model : Any)
    func onError(error : Error)
    
}

protocol MovieListDataProviderProtocol : DataProvider{
    
    
}
