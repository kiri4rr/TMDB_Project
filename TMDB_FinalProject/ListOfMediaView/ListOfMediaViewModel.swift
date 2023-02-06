//
//  ListOfMediaViewModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation

class ListOfMediaViewModel{
    
    var dataService: DataService? = DataService()
    var networkService: NetworkService? = NetworkService()
    
    var arrayOfMedia: [MediaModel] = Array<MediaModel>()
    var filteredMedia: [MediaModel] = Array<MediaModel>()
    var typeOfContent: String = Constants.singelton.movieType.lowercased()
    var isFiltered: Bool = false
    
    func setTypeOfContent(typeOfContent: String){
        self.typeOfContent = typeOfContent
    }
    
    func setArrayOfMedia(){
        if arrayOfMedia.count != 0 {
            arrayOfMedia.removeAll()
        }
        
        switch typeOfContent {
        case Constants.singelton.seriesType.lowercased():
            guard let arrayOfSeries = dataService?.getFilteredObjectsByType(needTypeOfMedia: Constants.singelton.seriesType.lowercased()) else{ return }
            for series in arrayOfSeries {
                let newSeries = MediaModel(URLStringOfMedia: series.posterPath, name: series.name)
                arrayOfMedia.append(newSeries)
            }
        default:
            guard let arrayOfMovie = dataService?.getFilteredObjectsByType(needTypeOfMedia: Constants.singelton.movieType.lowercased()) else{ return }
            for movie in arrayOfMovie {
                let newMovie = MediaModel(URLStringOfMedia: movie.posterPath, name: movie.name)
                arrayOfMedia.append(newMovie)
            }
        }
    }
    
    func refreshMedia(complition: @escaping (()->())) {
        switch typeOfContent {
        case Constants.singelton.seriesType.lowercased():
            networkService?.idOfMedia = dataService?.getFirstIndexOfSeries() ?? 0
            networkService?.getListOfTV()
        default:
            networkService?.idOfMedia = dataService?.getFirstIndexOfMovie() ?? 0
            networkService?.getListOfMovies()
        }
        DispatchQueue.main.async {
            self.setArrayOfMedia()
            complition()
        }
    }
}
