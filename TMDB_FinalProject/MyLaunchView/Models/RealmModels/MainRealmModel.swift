//
//  MainRealmModel.swift
//  TMDB_FinalProject
//
//  Created by Kirill Romanenko on 21.01.2023.
//

import Foundation
import RealmSwift

class MediaRealmModel: Object{
    @Persisted(primaryKey: true) var id = 0
    @Persisted var idOfMedia = 0
    @Persisted var posterPath: String = ""
    @Persisted var name: String = ""
    @Persisted var overview: String = ""
    @Persisted var voteAvarage: String = ""
    @Persisted var voteCount: String = ""
    @Persisted var firstAirDate: String = ""
    @Persisted var isFavourite: Bool = false
    @Persisted var keyOfTrailer: String = ""
    @Persisted var typeOfMedia: String = ""
}
