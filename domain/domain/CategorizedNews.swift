//
//  CategorizedNews.swift
//  domain
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation

public struct CategorizedNews {
    public let results: [Results]?
    
    public init(results: [CategorizedNews.Results]) {
        self.results = results
    }
    
    public struct Results {
        public let category: String?
        public let subCategory, title, abstract: String?
        public let url: String?
        public let byline: String?
        public let updatedDate, createdDate, publishedDate: String?
        public let multimedia: [Multimedia]?
        public let keywords: [String]?
        
        public init(category: String,
                    subCategory: String,
                    title: String,
                    abstract: String,
                    url: String,
                    byline: String,
                    updatedDate: String,
                    createdDate: String,
                    publishedDate: String,
                    multimedia: [CategorizedNews.Results.Multimedia],
                    keywords: [String]
        ) {
            self.category = category
            self.subCategory = subCategory
            self.title = title
            self.abstract = abstract
            self.url = url
            self.byline = byline
            self.updatedDate = updatedDate
            self.createdDate = createdDate
            self.publishedDate = publishedDate
            self.multimedia = multimedia
            self.keywords = keywords
        }
        
        // MARK: - Media
        public struct Multimedia {
            public let url: String?
            
            public init (url: String) {
                self.url = url
            }
        }
    }
}
