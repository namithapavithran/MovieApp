//
//  MovieListModel.swift
//  MovieApp
//
//  Created by user143649 on 4/18/19.
//  Copyright © 2019 user143649. All rights reserved.
//

import Foundation
struct MovieListModel: Decodable{
    let page: Int
    let total_results: Int
    let total_pages: Int
    var results: [MovieInfoModel]
    init(page: Int,total_results: Int,
         total_pages: Int,results: [MovieInfoModel]) {
        self.page = page
        self.total_results = total_results
        self.total_pages = total_pages
        self.results = results
    }
}
struct MovieInfoModel:Decodable{
    let adult: Bool?
    let backdrop_path: String?
    let genre_ids : [Int]?
    let id: Int?
    let original_language: String?
    let original_title: String?
    let overview: String?
    let popularity: Double?
    let poster_path: String?
    let release_date: String?
    let title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    
    init(adult: Bool,backdrop_path: String,genre_ids : [Int],id: Int,original_language: String,original_title: String,overview: String,popularity: Double,poster_path: String,release_date: String,title: String,video: Bool,vote_average: Double,vote_count: Int) {
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.genre_ids = genre_ids
        self.id = id
        self.original_language = original_language
        self.original_title = original_title
        self.overview = overview
        self.popularity = popularity
        self.poster_path = poster_path
        self.release_date = release_date
        self.title = title
        
        self.video = video
        self.vote_average = vote_average
        self.vote_count = vote_count
        
    }
}
/*adult = 0;
"backdrop_path" = "/beJbsLwOkKImXpImUzk3l3BXvY9.jpg";
"genre_ids" =     (
    99
);
id = 508003;
"original_language" = en;
"original_title" = McQueen;
overview = "Alexander McQueen's rags-to-riches story is a modern-day fairy tale, laced with the gothic. Mirroring the savage beauty, boldness and vivacity of his design, this documentary is an intimate revelation of McQueen's own world, both tortured and inspired, which celebrates a radical and mesmerizing genius of profound influence.";
popularity = "4.745";
"poster_path" = "/bc5kAqhNfLitH7zMlLvLRbxV0xD.jpg";
"release_date" = "2018-06-08";
title = McQueen;
video = 0;
"vote_average" = "8.199999999999999";
"vote_count" = 37;
*/
