//
//  SeriesResponseModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation

//MARK: - SeriesModel
struct SeriesModelResponse: Codable {
    let page: Int
    let results: [ResultSeries]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct ResultSeries: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name: String
    let originalLanguageSeries: String
    let originalName, overview, posterPath: String
    let mediaTypeSeries: String
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguageSeries = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaTypeSeries = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}

