//
//  PopularNews.swift
//  domain
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation

public struct PopularNews {
    public let results: [PopularResults]?
    
    public init(results: [PopularNews.PopularResults]) {
        self.results = results
    }
    
    public struct PopularResults {
        public let url: String?
        public let id: Int?
        public let updateDate: String?
        public let category: String?
        public let title: String?
        public let abstract: String?
        public let keywords: [String]?
        public let media: [Media]?
        public let byline: String?
        
        public init(url: String,
                    id: Int,
                    updateDate: String,
                    category: String,
                    title: String,
                    abstract: String,
                    keywords: [String],
                    media: [PopularNews.PopularResults.Media],
                    byline: String
        ) {
            self.url = url
            self.id = id
            self.updateDate = updateDate
            self.category = category
            self.title = title
            self.abstract = abstract
            self.keywords = keywords
            self.media = media
            self.byline = byline
        }
        
        // MARK: - Media
        public struct Media {
            public let mediaMetaData: [MetaData]?
            
            public init (mediaMetaData: [PopularNews.PopularResults.Media.MetaData]) {
                self.mediaMetaData = mediaMetaData
            }
            
            public struct MetaData {
                public let url: String?
                
                public init(url: String) {
                    self.url = url
                }
            }
        }
    }
}
