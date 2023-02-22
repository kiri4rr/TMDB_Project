//
//  FavouriteMediaRealmModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 22.02.2023.
//

import Foundation
import RealmSwift

class FavouriteMediaRealmModel: Object {
    @Persisted var idOfMedia = 0
    @Persisted var posterPath: String = ""
    @Persisted var name: String = ""
    @Persisted var overview: String = ""
    @Persisted var voteAvarage: String = ""
    @Persisted var voteCount: String = ""
    @Persisted var firstAirDate: String = ""
    @Persisted var keyOfTrailer: String = ""
    @Persisted var typeOfMedia: String = ""
}
