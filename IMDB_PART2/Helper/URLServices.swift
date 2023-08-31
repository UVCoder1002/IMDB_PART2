//
//  URLServices.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 26/08/23.
//

import Foundation


class URLService {
    
    private init() {
        
    }
    
    static var shared : URLService {
        let instance = URLService()
        return instance
    }
    
    func fetchMovieList(from urlString : String,completionBlock: @escaping ([Movie]?,Error?) -> Void) async  {
        
         print("func called")
         guard let url = URL(string: urlString) else { return  }
         print("url")
        var request = URLRequest(url: url)
         print("request")
        request.httpMethod = "GET"
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         print(request)

         let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
             print("hii")
           
              
            guard let response = response as? HTTPURLResponse else { return }
            if response.statusCode == 200 {

                guard let data = data else {
                    completionBlock(nil,error)
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userResponse = try? decoder.decode(Movies.self, from: data) else{
                    print("DEBUG: JSON decoding failed")
                    return
                }
                completionBlock(userResponse.results,nil)
         

                

            }
             else{
                 print("Error : response status: \(response.statusCode)")
             }
             
         }
        dataTask.resume()
        
    }
    
    func downloadImg(InputUrl url: String,completionBlock: @escaping (Data) -> Void){
        let imgURL = URL(string: url)!
        URLSession.shared.dataTask(with: imgURL) {
            (data,urlResponse,error) in
            guard error == nil else {
                print("We got an error \(error!.localizedDescription)")
                return
            }
            let response = urlResponse as? HTTPURLResponse
            guard response?.statusCode == 200 else{
                print("The HTTPResponse statusCode is : \(response!.statusCode)")
                return
            }
            guard let imgData = data else{
                return
            }
            completionBlock(imgData)
           
        }.resume()

    }
    
    func posterImageURL(from url : String) -> String{
        return Constants.moviePosterPathBaseURL + url
    }
}
