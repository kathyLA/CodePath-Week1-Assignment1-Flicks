//
//  Movie.swift
//  Movie
//
//  Created by kathy yin on 4/2/17.
//  Copyright © 2017 kathy. All rights reserved.
//

import Foundation
import AFNetworking

enum FetchType:String {
    case nowPlaying = "now_playing"
    case topRated = "top_rated"
}


private let params = ["api_key": "a07e22bc18f5cb106bfe4cc1f83ad8ed"]
private let baseUrl = "https://api.themoviedb.org/3/movie/"
private let baseImgUrl = "https://image.tmdb.org/t/p/w342"

class Movie {
    var overview: String
    var title: String
    var imageUrl: String
   
    init(jsonResult: NSDictionary) {
        self.overview = (jsonResult["overview"] as? String ?? "")
        self.title = (jsonResult["original_title"] as? String ?? "")
        self.imageUrl = baseImgUrl + (jsonResult["poster_path"] as? String ?? "")
    }
    
    class func loadMovies(queryCategory:FetchType, success:@escaping ([Movie])-> Void, fail: @escaping (Error)->Void)
    {
        let apiPath = baseUrl + queryCategory.rawValue
        let manager =  AFHTTPSessionManager()
        //set response serializer otherwise response can not direct cast to dictionary
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.get(apiPath, parameters: params, progress: nil, success: {(task, responseObject) in
            
             let dictionary = responseObject as? NSDictionary
             var movies: [Movie] = []
             if let results = dictionary?["results"] as? [NSDictionary] {
                for result in results {
                    movies.append(Movie(jsonResult: result))
                }
             }
             success(movies)
        }, failure: { (task, error) in
            fail(error)
        })
    }
}
