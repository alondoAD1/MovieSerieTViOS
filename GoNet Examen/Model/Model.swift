//
//  Model.swift
//  GoNet Examen
//
//  Created by A on 24/11/21.
//

import Foundation


struct MovieResult: Decodable {
//    let dates: Dates
//    let page: Int
    let results: [Result]
//    let totalPages, totalResults: Int
//    let Account: [Account]
    enum CodingKeys: String, CodingKey {
        case results
//        case Account

//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
    
}

//struct Dates: Codable {
//    let maximum, minimum: String
//}

struct Account: Decodable {
    let account_id: String
    let access_token: String
    let success: Bool
    let status_message: String
    let status_code: Int
}

struct TVResult: Decodable {
    let results: [Resultseries]

//    enum CodingKeys: String, CodingKey {
//        case results
//
//    }
    
    enum CodingKeys: String, CodingKey {
        case results = "results"

    }

    
}

struct TVResultTop: Decodable {
    let page: Int
    let results: [ResultseriesTop]
    let total_results: Int
    let total_pages: Int
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case total_results = "total_results"
        case total_pages = "total_pages"

    }
    
}

struct Result: Decodable {
    let poster_path: String
    let adult: Bool
    let overview: String
    let release_date: String

    
//    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String // creo este es el error por eso no muestra en TVShows, en TVSHOW cambiar title por name que ahi esta el error
    let backdrop_path: String
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Double

//    let original_language: OriginalLanguage
//    let original_title, overview: String
//    let popularity: Double
//    let poster_path, release_date, title: String
//    let video: Bool
//    let vote_average: Double
//    let vote_count: Int
    
//    enum CodingKeys: String, CodingKey {
//        case poster_path = "poster_path"
//        case adult = "adult"
//        case overview = "overview"
//        case release_date = "release_date"
//        case genre_ids = "genre_ids"
//        case id = "id"
//        case original_title = "original_title"
//        case original_language = "original_language"
//        case title = "title"
//        case backdrop_path = "backdrop_path"
//        case popularity = "popularity"
//        case vote_count = "vote_count"
//        case video = "video"
//        case vote_average = "vote_average"
//    }
    
    
}

struct Resultseries: Decodable {
    let poster_path: String
    let popularity: Double
    let id: Int
    let backdrop_path: String
    let vote_average: Double
    let overview: String
    let first_air_date: String
    let origin_country: [String]
    let genre_ids: [Int]
    let original_language: String
    let vote_count: Int
    let name: String
    let original_name: String
    
//    enum CodingKeys: String, CodingKey {
//        case poster_path = "poster_path"
//        case popularity = "popularity"
//        case id = "id"
//        case backdrop_path = "backdrop_path"
//        case vote_average = "vote_average"
//        case overview = "overview"
//        case first_air_date = "first_air_date"
//        case origin_country = "origin_country"
//        case genre_ids = "genre_ids"
//        case original_language = "original_language"
//        case vote_count = "vote_count"
//        case name = "name"
//        case original_name = "original_name"
//
//    }
//
    
}

struct ResultseriesTop: Decodable {
    let backdrop_path: String
    let first_air_date: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_name: String
    let overview: String
    let origin_country: [String]

    let poster_path: String
    let popularity: Double
    let name: String

    let vote_count: Int
    
    let vote_average: Double

        enum CodingKeys: String, CodingKey {
            case poster_path = "poster_path"
            case popularity = "popularity"
            case id = "id"
            case backdrop_path = "backdrop_path"
            case vote_average = "vote_average"
            case overview = "overview"
            case first_air_date = "first_air_date"
            case origin_country = "origin_country"
            case genre_ids = "genre_ids"
            case original_language = "original_language"
            case vote_count = "vote_count"
            case name = "name"
            case original_name = "original_name"
    
        }
    
}


struct MovieResultTopRated: Decodable {
    let results: [ResultTopRated]

    enum CodingKeys: String, CodingKey {
        case results
    }
    
}

struct ResultTopRated: Decodable {
    let poster_path: String
    let adult: Bool
    let overview: String
    let release_date: String

    
//    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Double

//    let original_language: OriginalLanguage
//    let original_title, overview: String
//    let popularity: Double
//    let poster_path, release_date, title: String
//    let video: Bool
//    let vote_average: Double
//    let vote_count: Int
    
    enum CodingKeys: String, CodingKey {
        case poster_path = "poster_path"
        case adult = "adult"
        case overview = "overview"
        case release_date = "release_date"
        case genre_ids = "genre_ids"
        case id = "id"
        case original_title = "original_title"
        case original_language = "original_language"
        case title = "title"
        case backdrop_path = "backdrop_path"
        case popularity = "popularity"
        case vote_count = "vote_count"
        case video = "video"
        case vote_average = "vote_average"
    }
    
    
}


enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
}

struct MovieData: Decodable {
    let movies: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
    
}

struct Movie: Decodable {
    let title: String?
    let year: String?
    let ratio: String?
    let imagenPost: String?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case ratio = "vote_average"
        case imagenPost = "poster_path"
    }
    
}

struct MovieTrailer: Decodable {
    let id: Int?
    let results: [MovieTrailerresult]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case results = "results"

    }
    
}

struct MovieTrailerresult: Decodable {
    let iso_639_1: String?
    let iso_3166_1: String?
    let name: String?
    let key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let published_at: String?
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case iso_639_1 = "iso_639_1"
        case iso_3166_1 = "iso_3166_1"
        case name = "name"
        case key = "key"
        case site = "site"
        case size = "size"
        case type = "type"
        case official = "official"
        case published_at = "published_at"
        case id = "id"

    }
    
}


