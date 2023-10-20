//
//  MovieListViewControllerExtension.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 29/08/23.
//

import Foundation
import UIKit


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
         self.movieListModel = ViewModel(movieList: [:],filteredList: [])
        print("DEBUG: inside initdataprovider")
        self.movieListModel?.movieList.addObserver(self) { updatedMovieListViewModel in
            DispatchQueue.main.async {
                print("DEBUG: RELOAD TABLE")
                self.movieListView.reloadData()
            }
            
            
        }
         self.movieListModel?.filteredList?.addObserver(self, completion: { filteresList in
             self.movieListView.reloadData()
         })
         DispatchQueue.main.async {
             self.showLoadingAlert()
         }
         let varTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false)
         { (varTimer) in
             self.movieListModel?.getMovieList(from: Constants.fetchMovieListURLString + self.currentPage.description,pagination: false){
                 DispatchQueue.main.async {
                     self.hideLoadingAlert()
                 }
                 
                 
             }
         }
       


    }
    
    func showLoadingFooter() {
        let progressView = UIActivityIndicatorView(style: .medium)
        progressView.startAnimating()
        progressView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.movieListView.bounds.width, height: CGFloat(44))
        self.movieListView.tableFooterView = progressView
        self.movieListView.tableFooterView?.isHidden = false
    }
    
    func hideLoadingFooter(){
        self.movieListView.tableFooterView?.isHidden = true
        self.movieListView.tableFooterView = nil
    }
    
    
    func showLoadingAlert(){
        let alert = UIAlertController(title: nil, message: "Please Wait", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: true)
    }
    
    func hideLoadingAlert() {
        dismiss(animated: false)
    }
}

extension MovieListViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            self.movieListView.reloadData()
        }
        else{
            isSearching = true
            movieListModel?.searchMovie(searchText: searchText)
        }
    }
}
