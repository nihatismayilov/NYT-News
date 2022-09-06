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
        let publishedDate: String?
        let category: String?
        let title: String?
        let abstract: String?
        let media: MediaDTO?
        
        enum CodingKeys: String, CodingKey {
            case publishedDate = "published_date"
            case url, id, title, abstract, media
            case category = "section"
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
