//
//  SearchNewsResponseDTO.swift
//  data
//
//  Created by Nihad Ismayilov on 12.09.22.
//

import Foundation

struct SearchNewsResponseDTO: Decodable {
    let response: Response?
    
    struct Response: Decodable {
        let docs: [Doc]?
    }

}

extension SearchNewsResponseDTO.Response {
    struct Doc: Decodable {
        let abstract: String?
        let webURL: String?
        let multimedia: [Multimedia]?
        let headline: Headline?
        let pubDate: String?
        let category: String?
        let subCategory: String?
        let byline: Byline?
        let id: String?

        enum CodingKeys: String, CodingKey {
            case abstract
            case webURL = "web_url"
            case multimedia, headline
            case pubDate = "pub_date"
            case category = "section_name"
            case subCategory = "subsection_name"
            case byline
            case id = "_id"
        }
    }
}

extension SearchNewsResponseDTO.Response.Doc {
    struct Multimedia: Decodable {
        let url: String?
    }
    
    struct Headline: Decodable {
        let main: String?
        let printHeadline: String?

        enum CodingKeys: String, CodingKey {
            case printHeadline = "print_headline"
            case main
        }
    }
    
    struct Byline: Decodable {
        let original: String?
    }
}
