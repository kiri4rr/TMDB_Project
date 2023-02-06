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
        guard let media = dataService?.getMediaByName(name) else {return}
        print("Start setting data to DetailModel")
        detailModel = DetailModel(URLStringOfImage: media.posterPath,
                                  name: media.name,
                                  overview: media.overview,
                                  voteAvarage: media.voteAvarage,
                                  voteCount: media.voteCount,
                                  firstAirDate: media.firstAirDate,
                                  keyOfTrailer: media.keyOfTrailer)
        print(detailModel?.URLStringOfImage ?? "")
        print(detailModel?.name ?? "")
        print(detailModel?.overview ?? "")
        print(detailModel?.voteAvarage ?? "")
        print(detailModel?.voteCount ?? "")
        print(detailModel?.firstAirDate ?? "")
        print(detailModel?.keyOfTrailer ?? "")
        print("End setting data to DetailModel")
        complition()
        print("End complition")
    }
    
    func addMediaToFavourite() {
        guard let media = dataService?.getMediaByName(name) else {return}
        dataService?.setFavourite(value: media, isFavourite: true)
    }
    
    func deleteMediaFromFavourite() {
        guard let media = dataService?.getMediaByName(name) else {return}
        dataService?.setFavourite(value: media, isFavourite: false)
    }
    
    func checkIsFavourite() -> Bool {
        guard let media = dataService?.getMediaByName(name) else {return false}
        var isFavourite = false
        if media.isFavourite {
            isFavourite = true
        }
        return isFavourite
    }
    
}
