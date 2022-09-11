//
//  Mapper.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import domain

extension PopularNewsResponseDTO.PopularResultsDTO.MediaDTO.MetaDataDTO {
    func toDomain() -> PopularNews.PopularResults.Media.MetaData {
        return PopularNews.PopularResults.Media.MetaData.init(url: self.url ?? "")
    }
}

extension PopularNewsResponseDTO.PopularResultsDTO.MediaDTO {
    func toDomain() -> PopularNews.PopularResults.Media {
        return PopularNews.PopularResults.Media.init(mediaMetaData: self.mediaMetaData.map({$0.map{$0.toDomain()}})!)
    }
}

extension PopularNewsResponseDTO.PopularResultsDTO {
    func toDomain() -> PopularNews.PopularResults {
        return PopularNews.PopularResults.init(url: self.url ?? "", id: self.id ?? 0, updateDate: self.updateDate ?? "", category: self.category ?? "", title: self.title ?? "", abstract: self.abstract ?? "", media: self.media.map({$0.map {$0.toDomain()}})!)
    }
}

extension PopularNewsResponseDTO {
    func toDomain() -> PopularNews {
        return PopularNews.init(results: self.results.map({$0.map {$0.toDomain()}})!)
    }
}
