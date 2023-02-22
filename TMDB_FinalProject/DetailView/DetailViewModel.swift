//
//  DetailViewModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation

class DetailViewModel{
    
    var dataService: DataService? = DataService()
    var networkService: NetworkService? = NetworkService()
    
    var name: String = ""
    var detailModel: DetailModel?
    var typeOfContent: String = ""
    
    func setKeyOfTrailer(complition: @escaping (()->())) {
        networkService?.getKeyOfTrailer(name: name, typeOfContent: typeOfContent) { [weak self] in
            guard let self = self else {return}
            self.setDataToDetailModel {
                complition()
            }
        }
    }
    
    func setDataToDetailModel(complition: @escaping (()->())) {
        guard let media = dataService?.getFavouriteMediaByName(name) else {
            guard let favouriteMedia = dataService?.getMediaByName(name) else {return}
            setData(favouriteMedia)
            complition()
            return
        }
        setData(media)
        complition()
    }
    
    private func setData(_ media: MediaRealmModel){
        detailModel = DetailModel(URLStringOfImage: media.posterPath,
                                  name: media.name,
                                  overview: media.overview,
                                  voteAvarage: media.voteAvarage,
                                  voteCount: media.voteCount,
                                  firstAirDate: media.firstAirDate,
                                  keyOfTrailer: media.keyOfTrailer)
    }
    
    private func setData(_ media: FavouriteMediaRealmModel){
        detailModel = DetailModel(URLStringOfImage: media.posterPath,
                                  name: media.name,
                                  overview: media.overview,
                                  voteAvarage: media.voteAvarage,
                                  voteCount: media.voteCount,
                                  firstAirDate: media.firstAirDate,
                                  keyOfTrailer: media.keyOfTrailer)
    }
    
    func addMediaToFavourite() {
        guard let media = dataService?.getMediaByName(name) else {return}
        dataService?.setFavourite(value: media)
    }
    
    func deleteMediaFromFavourite() {
        guard let media = dataService?.getFavouriteMediaByName(name) else {return}
        dataService?.deleteFromFavourite(value: media)
    }
    
    func checkIsFavourite() -> Bool {
        var isFavourite = false
        if dataService?.checkIsFavourite(name: name) ?? false {
            isFavourite = true
        }
        return isFavourite
    }
    
}
