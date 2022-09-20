//
//  PopularNewsResponseDTO.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation

struct PopularNewsResponseDTO: Decodable {
    let results: [PopularResultsDTO]?
    
    struct PopularResultsDTO: Decodable {
        let url: String?
        let id: Int?
        let updateDate: String?
        let category: String?
        let title: String?
        let abstract: String?
        let keywords: [String]?
        let media: [MediaDTO]?
        let byline: String?
        
        enum CodingKeys: String, CodingKey {
            case url, id, title, abstract, media
            case updateDate = "updated"
            case category = "section"
            case keywords = "des_facet"
            case byline
        }
    }
}

extension PopularNewsResponseDTO.PopularResultsDTO {
    struct MediaDTO: Decodable {
        let mediaMetaData: [MetaDataDTO]?
        
        enum CodingKeys: String, CodingKey {
            case mediaMetaData = "media-metadata"
        }
    }
}

extension PopularNewsResponseDTO.PopularResultsDTO.MediaDTO {
    struct MetaDataDTO: Codable {
        let url: String?
    }
}
