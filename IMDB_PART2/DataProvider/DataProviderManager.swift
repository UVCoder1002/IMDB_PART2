//
//  DataProviderManager.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 28/08/23.
//

import Foundation


class DataProviderManager<T,S> {
    
    typealias CompletionHandler = ((T) -> Void)
    
    var value : T{
        didSet{
            self.notifyObserver(self.observers)
        }
    }
    
    var secondValue : S?{
        didSet{
            self.notifyObserver(self.observers)
        }
    }
    
    var observers : [Int : CompletionHandler] = [:]
    
    init(value: T,secondValue: S){
        self.value = value
        self.secondValue = secondValue
    }
    init(value: T){
        self.value = value
    }
    
    func addObserver(_ observer: DataProvider,completion: @escaping CompletionHandler) {
        self.observers[observer.id] = completion
    }
    
    func removeObserver(_ observer: DataProvider) {
        self.observers.removeValue(forKey: observer.id)
    }
    
    func notifyObserver(_ observers: [Int : CompletionHandler]) {
        observers.forEach({ $0.value(value)})
    }
    
    deinit{
        observers.removeAll()
    }
        
   
}
