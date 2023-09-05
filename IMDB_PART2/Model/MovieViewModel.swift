//
//  MovieViewModel.swift
//  IMDB_PART2
//
//  Created by Urvashi Gupta on 26/08/23.
//

import Foundation

 class Movie : MovieListable,Codable{
    var id : Int64
    var posterPath : String?
    var overview : String?
    var voteAverage : Double?
    var title : String?
    var popularity : Double?
    var releaseDate: String?
    var posterImage : Data?
    
    init(id: Int64, posterPath: String, overView: String, voteAverage: Double, title: String, popularity: Double, releaseDate: String, posterImage: Data? = nil) {
        self.id = id
        self.posterPath = posterPath
        self.overview = overView
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.releaseDate = releaseDate
        self.posterImage = posterImage
    }
    
   
    
}

protocol MovieListable {
    var id : Int64 { get set }
    var title : String? { get set }
    var posterPath : String? { get set }
    var overview : String? { get set}
    var posterImage : Data?  { get set }
}

struct Movies: Codable {
    var dates : [String : String]
    var page : Int64
    var totalPages : Int64
    var totalResults : Int64
    var results : [Movie]
}

extension Movie{
    static let MOCK_MOVIE = Movie(id: 976573,posterPath: "/8riWcADI1ekEiBguVB9vkilhiQm.jpg",overView :  "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common." ,voteAverage : 7.8,title :"Elemental" ,popularity : 2933.943 ,releaseDate: "2023-06-14")
}
