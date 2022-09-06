//
//  PopularNews.swift
//  domain
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation

public struct PopularNews {
    public let results: [PopularResults]?
    
    public init(
        results: [PopularNews.PopularResults]
    ) {
        self.results = results
    }
    
    public struct PopularResults {
        public let url: String?
        public let id: Int?
        public let publishedDate: String?
        public let category: String?
        public let title: String?
        public let abstract: String?
        public let media: Media?
        
        public init(url: String,
                    id: Int,
                    publishedDate: String,
                    category: String,
                    title: String,
                    abstract: String,
                    media: PopularNews.PopularResults.Media
        ) {
            self.url = url
            self.id = id
            self.publishedDate = publishedDate
            self.category = category
            self.title = title
            self.abstract = abstract
            self.media = media
        }
        
        // MARK: - Media
        public struct Media {
            public let mediaMetaData: [MetaData]?
            
            public init (
                mediaMetaData: [PopularNews.PopularResults.Media.MetaData]
            ) {
                self.mediaMetaData = mediaMetaData
            }
            
            public struct MetaData {
                let url: String?
                
                public init(
                    url: String
                ) {
                    self.url = url
                }
            }
        }
    }
}
