//
//  Mapper.swift
//  data
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import domain

// MARK: - PopularNews
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
        return PopularNews.PopularResults.init(url: self.url ?? "", id: self.id ?? 0, updateDate: self.updateDate ?? "", category: self.category ?? "", title: self.title ?? "", abstract: self.abstract ?? "", keywords: self.keywords ?? [], media: self.media.map({$0.map {$0.toDomain()}})!, byline: self.byline ?? "")
    }
}

extension PopularNewsResponseDTO {
    func toDomain() -> PopularNews {
        return PopularNews.init(results: self.results.map({$0.map {$0.toDomain()}})!)
    }
}

// MARK: - CategorizedNews

extension CategorizedNewsResponseDTO.ResultsDTO.Multimedia {
    func toDomain() -> CategorizedNews.Results.Multimedia {
        return CategorizedNews.Results.Multimedia.init(url: self.url ?? "")
    }
}

extension CategorizedNewsResponseDTO.ResultsDTO {
    func toDomain() -> CategorizedNews.Results {
        return CategorizedNews.Results(category: self.category ?? "", subCategory: self.subCategory ?? "", title: self.title ?? "", abstract: self.abstract ?? "", url: self.url ?? "", byline: self.byline ?? "", updatedDate: self.updatedDate ?? "", createdDate: self.createdDate ?? "", publishedDate: self.publishedDate ?? "", multimedia: self.multimedia.map({$0.map {$0.toDomain()}}) ?? [CategorizedNews.Results.Multimedia(url: "")], keywords: self.keywords ?? [])
    }
}

extension CategorizedNewsResponseDTO {
    func toDomain() -> CategorizedNews {
        return CategorizedNews.init(results: self.results.map({$0.map {$0.toDomain()}})!)
    }
}

// MARK: - SearchNews

extension SearchNewsResponseDTO.Response.Doc.Keyword {
    func toDomain() -> SearchNews.Response.Doc.Keyword {
        return SearchNews.Response.Doc.Keyword(keyword: self.keyword ?? "")
    }
}

extension SearchNewsResponseDTO.Response.Doc.Byline {
    func toDomain() -> SearchNews.Response.Doc.Byline {
        return SearchNews.Response.Doc.Byline(original: self.original ?? "")
    }
}

extension SearchNewsResponseDTO.Response.Doc.Headline {
    func toDomain() -> SearchNews.Response.Doc.Headline {
        return SearchNews.Response.Doc.Headline(main: self.main ?? "", printHeadline: self.printHeadline ?? "")
    }
}

extension SearchNewsResponseDTO.Response.Doc.Multimedia {
    func toDomain() -> SearchNews.Response.Doc.Multimedia {
        return SearchNews.Response.Doc.Multimedia(url: self.url ?? "")
    }
}

extension SearchNewsResponseDTO.Response.Doc {
    func toDomain() -> SearchNews.Response.Doc {
        return SearchNews.Response.Doc(abstract: self.abstract ?? "", webURL: self.webURL ?? "", multimedia: self.multimedia.map({$0.map {$0.toDomain()}})!, headline: self.headline!.toDomain(), keywords: self.keywords.map({$0.map{$0.toDomain()}})!, pubDate: self.pubDate ?? "", category: self.category ?? "", subCategory: self.subCategory ?? "", byline: self.byline!.toDomain(), id: self.id ?? "")
    }
}

extension SearchNewsResponseDTO.Response {
    func toDomain() -> SearchNews.Response {
        return SearchNews.Response.init(docs: self.docs.map({$0.map {$0.toDomain()}})!)
    }
}

extension SearchNewsResponseDTO {
    func toDomain() -> SearchNews {
        return SearchNews.init(response: (self.response?.toDomain()) ?? SearchNews.Response(docs: []))
    }
}
