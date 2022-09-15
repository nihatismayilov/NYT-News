//
//  SearchNews.swift
//  domain
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation

public struct SearchNews {
    public let response: Response?
    
    public init(response: SearchNews.Response) {
        self.response = response
    }
    
    public struct Response {
        public let docs: [Doc]?
        
        public init(docs: [SearchNews.Response.Doc]) {
            self.docs = docs
        }
        
        public struct Doc {
            public let abstract: String?
            public let webURL: String?
            public let multimedia: [Multimedia]?
            public let headline: Headline?
            public let pubDate: String?
            public let category: String?
            public let subCategory: String?
            public let byline: Byline?
            public let id: String?
            
            public init(abstract: String,
                        webURL: String,
                        multimedia: [SearchNews.Response.Doc.Multimedia],
                        headline: SearchNews.Response.Doc.Headline,
                        pubDate: String,
                        category: String,
                        subCategory: String,
                        byline: SearchNews.Response.Doc.Byline,
                        id: String
            ) {
                self.abstract = abstract
                self.webURL = webURL
                self.multimedia = multimedia
                self.headline = headline
                self.pubDate = pubDate
                self.category = category
                self.subCategory = subCategory
                self.byline = byline
                self.id = id
            }
            
            public struct Multimedia {
                public let url: String?
                
                public init(url: String) {
                    self.url = url
                }
            }
            
            public struct Headline {
                public let main: String?
                public let printHeadline: String?
                
                public init(
                    main: String,
                    printHeadline: String
                ) {
                    self.main = main
                    self.printHeadline = printHeadline
                }
            }
            
            public struct Byline {
                public let original: String?
                
                public init(original: String) {
                    self.original = original
                }
            }
        }
    }
}
