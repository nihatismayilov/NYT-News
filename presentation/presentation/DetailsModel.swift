//
//  DetailsModel.swift
//  presentation
//
//  Created by Nihad Ismayilov on 15.09.22.
//

import Foundation

public struct DetailsModel: Equatable, Codable {
    public let image: String?
    public let title: String?
    public let description: String?
    public let writtenBy: String?
    public let category: String?
    public let webUrl: String?
    public let id: String?
    public let pubDate: String?
}
