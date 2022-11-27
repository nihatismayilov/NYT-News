//
//  CategorizedNewsResponseDTO.swift
//  data
//
//  Created by Nihad Ismayilov on 11.09.22.
//

import Foundation

struct CategorizedNewsResponseDTO: Decodable {
    let results: [ResultsDTO]?
    
    struct ResultsDTO: Decodable {
        let category: String?
        let subCategory, title, abstract: String?
        let url: String?
        let byline: String?
        let updatedDate, createdDate, publishedDate: String?
        let multimedia: [Multimedia]?
        let keywords: [String]?

        enum CodingKeys: String, CodingKey {
            case category = "section"
            case subCategory = "subsection"
            case title, abstract, url, byline
            case updatedDate = "updated_date"
            case createdDate = "created_date"
            case publishedDate = "published_date"
            case multimedia
            case keywords = "des_facet"
        }
    }
}

extension CategorizedNewsResponseDTO.ResultsDTO {
    struct Multimedia: Decodable {
        let url: String?
    }
}
