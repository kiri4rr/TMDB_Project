//
//  MyLaunchViewModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation

class MyLaunchViewModel{
    
    let networkService: NetworkService? = NetworkService()
    
    func getListOfData(complition: @escaping (()->())){
        networkService?.getListOfData {
            complition()
        }
    }
    
    deinit {
        print("\(MyLaunchViewModel.self) deinited!")
    }
}
