//
//  DataProviderManager.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 28/08/23.
//

import Foundation


class DataProviderManager<T,S> {
    
    var delegate : [T]?
    var model : S?
    
    func addDelegate(observer: T){
        
    }
    
    func deleteDelegate(){
        
    }
    func notifyDelegates(model: [S]?,error: Error?){
        
    }
}
