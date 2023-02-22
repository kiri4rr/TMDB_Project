//
//  ListOfFavouriteMediaViewModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation

class ListOfFavouriteViewModel{
    var dataService: DataService? = DataService()
    var favouriteMediaModel: Array<FavouriteMediaModel>? = Array<FavouriteMediaModel>()
    
    func setArrayOfFavouriteMedia(){
        if favouriteMediaModel?.count != 0 {
            favouriteMediaModel?.removeAll()
        }
        guard let arrayOfFavouriteMedia = dataService?.getFavouriteMedia() else {return}
        
        for favouriteMedia in arrayOfFavouriteMedia {
            favouriteMediaModel?.append(FavouriteMediaModel(URLStringOfImage: favouriteMedia.posterPath,
                                                            name: favouriteMedia.name))
        }
    }
    
    func deleteFromFavourite(index: Int, complition: @escaping (()->())){
        guard let name = favouriteMediaModel?[index].name else {return}
        guard let value = dataService?.getFavouriteMediaByName(name) else {return}
        favouriteMediaModel?.remove(at: index)
        dataService?.deleteFromFavourite(value: value)
        complition()
    }
    
}
