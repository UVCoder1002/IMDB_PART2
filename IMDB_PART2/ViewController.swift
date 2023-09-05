//
//  ViewController.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 26/08/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.showLoadingAlert()
        }
       
        // Do any additional setup after loading the view.
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
}

