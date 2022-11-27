//
//  PopularNewsLocalDTO.swift
//  data
//
//  Created by Nihad Ismayilov on 26.09.22.
//

import Foundation

import Realm
import RealmSwift

class PopularNewsLocalDTO: Object {
    @Persisted var url: String = ""
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var updateDate: String = ""
    @Persisted var category: String = ""
    @Persisted var title: String = ""
    @Persisted var abstract: String = ""
    @Persisted var keywords: List<String> = .init()
    @Persisted var multimedia: List<String> = .init()
    @Persisted var byline: String = ""
    
    convenience init(
        url: String,
        id: String,
        updateDate: String,
        category: String,
        title: String,
        abstract: String,
        keywords: [String],
        multimedia: [String],
        byline: String
    ) {
        self.init()
        self.url = url
        self.id = id
        self.updateDate = updateDate
        self.category = category
        self.title = title
        self.abstract = abstract
        self.keywords.append(objectsIn: keywords)
        self.multimedia.append(objectsIn: multimedia)
    }
}
