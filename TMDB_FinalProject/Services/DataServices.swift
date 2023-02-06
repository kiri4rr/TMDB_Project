//
//  DataServices.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation
import RealmSwift

protocol DataServices {
    
}

class DataService: DataServices{
    
    private let realm = try? Realm()
    
    func deleteObjectsFromRealm(){
        try? realm?.write{
            realm?.deleteAll()
        }
    }
    
    func saveMovieToRealm(movie: Result, id: Int){
        
        let mediaRealmModel = MediaRealmModel()
        mediaRealmModel.id = id
        mediaRealmModel.idOfMedia = movie.id
        mediaRealmModel.name = movie.title
        mediaRealmModel.overview = movie.overview
        mediaRealmModel.posterPath = movie.posterPath
        mediaRealmModel.firstAirDate = movie.releaseDate
        mediaRealmModel.voteAvarage = String(movie.voteAverage)
        mediaRealmModel.voteCount = String(movie.voteCount)
        mediaRealmModel.typeOfMedia = "movie"
        addToRealm(value: mediaRealmModel)
        
    }
    
    func saveSeriesToRealm(tv: ResultSeries, id: Int){
        
        let mediaRealmModel = MediaRealmModel()
        mediaRealmModel.id = id
        mediaRealmModel.idOfMedia = tv.id
        mediaRealmModel.name = tv.name
        mediaRealmModel.overview = tv.overview
        mediaRealmModel.posterPath = tv.posterPath
        mediaRealmModel.firstAirDate = tv.firstAirDate
        mediaRealmModel.voteAvarage = String(tv.voteAverage)
        mediaRealmModel.voteCount = String(tv.voteCount)
        mediaRealmModel.typeOfMedia = "series"
        addToRealm(value: mediaRealmModel)
        
    }
    
    func updateMovieInRealm(movie: Result, id: Int) -> Bool {
        guard let media = realm?.object(ofType: MediaRealmModel.self, forPrimaryKey: id) else{
            print("no movie by this ID")
            return false
        }
        if !media.isFavourite || media.name.contains(movie.title) {
            try? realm?.write{
                media.idOfMedia = movie.id
                media.name = movie.title
                media.overview = movie.overview
                media.posterPath = movie.posterPath
                media.firstAirDate = movie.releaseDate
                media.voteAvarage = String(movie.voteAverage)
                media.voteCount = String(movie.voteCount)
                media.typeOfMedia = "movie"
            }
            return true
        }
        return false
    }
    
    func updateSeriesInRealm(series: ResultSeries, id: Int) -> Bool {
        guard let media = realm?.object(ofType: MediaRealmModel.self, forPrimaryKey: id) else{
            print("no series by this ID")
            return false
        }
        if !media.isFavourite || media.name.contains(series.name) {
            try? realm?.write{
                media.idOfMedia = series.id
                media.name = series.name
                media.overview = series.overview
                media.posterPath = series.posterPath
                media.firstAirDate = series.firstAirDate
                media.voteAvarage = String(series.voteAverage)
                media.voteCount = String(series.voteCount)
                media.typeOfMedia = "series"
            }
            return true
        }
        return false
    }
    
    func addToRealm(value: MediaRealmModel) {
        try? realm?.write{
            realm?.add(value)
        }
    }
    
    func getNumberOfMediaData() -> Int {
        guard let numberOfData = realm?.objects(MediaRealmModel.self).count else{
            return 0
        }
        return numberOfData
    }
    
    func getObjectsOfMediaFromRealm() -> Results<MediaRealmModel>? {
        guard let mediaObjects = realm?.objects(MediaRealmModel.self) else {
            return nil
        }
        return mediaObjects
    }
    
    func getFilteredObjectsByType(needTypeOfMedia: String) -> Results<MediaRealmModel>? {
        
        let arrayOfFilteredMedia: Results<MediaRealmModel>? = realm?.objects(MediaRealmModel.self).where{
            $0.typeOfMedia == needTypeOfMedia
        }
        guard arrayOfFilteredMedia != nil else {
            return nil
        }
        return arrayOfFilteredMedia
    }
    
    func getFirstIndexOfMovie() -> Int{
        let index = self.getObjectsOfMediaFromRealm()?.first{
            $0.typeOfMedia == "movie"
        }
        guard let id = index?.id else { return 0}
        return id
    }
    
    func getFirstIndexOfSeries() -> Int{
        let index = self.getObjectsOfMediaFromRealm()?.first{
            $0.typeOfMedia == "series"
        }
        guard let id = index?.id else { return 0}
        return id
    }
    
    func getMediaByName(_ name: String) -> MediaRealmModel? {
        guard let value = self.getObjectsOfMediaFromRealm()?.where({ $0.name == name }).first else { return nil }
        return value
    }
    
    func setKeyOfTrailer(value: MediaRealmModel, keyOfTrailer: String){
        try? realm?.write{
            value.keyOfTrailer = keyOfTrailer
        }
    }
    
    func setFavourite(value: MediaRealmModel, isFavourite: Bool) {
        try? realm?.write{
            value.isFavourite = isFavourite
        }
    }
    
    func getFavouriteMedia() -> Results<MediaRealmModel>?{
        guard let arrayOfFavouriteMedia = realm?.objects(MediaRealmModel.self).where({$0.isFavourite == true}) else {return nil}
        return arrayOfFavouriteMedia
        
    }
    
}
