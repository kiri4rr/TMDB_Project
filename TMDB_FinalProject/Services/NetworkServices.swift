//
//  NetwrokServices.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation
import Alamofire

protocol NetworkServices {
    func getListOfMovies()
    func getListOfTV()
    func getKeyOfTrailer(name: String, typeOfContent: String, complition: @escaping (()->()))
}

class NetworkService: NetworkServices {
    
    let dataService: DataService = DataService()
    let numberOfPages = 4
    var idOfMedia = 0
    
    func getListOfData(complition: @escaping (()->())){
        getListOfMovies()
        getListOfTV()
        DispatchQueue.main.async {
            print(self.dataService.getNumberOfMediaData())
            if self.dataService.getNumberOfMediaData() > 80{
                complition()
            }
        }
    }
    
    func getListOfMovies() {
        guard NetworkMonitor.shared.isConnected else { return }
        for page in 1...numberOfPages {
            let URLForMovies = Constants.singelton.getURLForMovie(page: page, typeOfContent: Constants.singelton.movieType.lowercased())
            AF.request(URLForMovies).response{[weak self] (response) -> Void in
                guard let self = self else { return }
                do{
                    guard let data = response.data else{ return }
                    let responseData = try JSONDecoder().decode(MovieResponseModel.self, from: data)
                    guard !responseData.results.isEmpty else { return}
                    for movie in responseData.results {
                        if !self.dataService.updateMovieInRealm(movie: movie, id: self.idOfMedia){
                            self.dataService.saveMovieToRealm(movie: movie, id: self.idOfMedia)
                        }
                        self.idOfMedia += 1
                    }
                    
                }catch{
                    print(error)
                }
                
            }
        }
    }
    
    func getListOfTV() {
        guard NetworkMonitor.shared.isConnected else { return }
        for page in 1...numberOfPages {
            let URLForTV = Constants.singelton.getURLForMovie(page: page, typeOfContent: Constants.singelton.seriesType.lowercased())
            AF.request(URLForTV).response{[weak self] (response) in
                guard let self = self else { return }
                do{
                    guard let data = response.data else{ return }
                    let responseData = try JSONDecoder().decode(SeriesModelResponse.self, from: data)
                    guard !responseData.results.isEmpty else { return }
                    for series in responseData.results {
                        if !self.dataService.updateSeriesInRealm(series: series, id: self.idOfMedia){
                            self.dataService.saveSeriesToRealm(tv: series, id: self.idOfMedia)
                        }
                        self.idOfMedia += 1
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    
    func getKeyOfTrailer(name: String, typeOfContent: String, complition: @escaping (()->())) {
        guard let value = dataService.getMediaByName(name) else {return}
        let URL: String = Constants.singelton.getURLForKeyOfVideo(id: value.idOfMedia, typeOfContent: typeOfContent)
        AF.request(URL).response{ [weak self] response in
            guard let self = self else { return }
            do{
                guard let responseData = response.data else{return}
                let data = try JSONDecoder().decode(KeyOFVideoResponse.self,
                                                            from: responseData)
                var keyOfTrailer = ""
                for item in data.results{
                    if item.type == "Trailer" {
                        keyOfTrailer = item.key
                    }
                }
                self.dataService.setKeyOfTrailer(value: value, keyOfTrailer: keyOfTrailer)
                complition()
            }catch {
                print(error)
            }
        }
    }
    
}
