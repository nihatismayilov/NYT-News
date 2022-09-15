//
//  ExploreVM.swift
//  presentation
//
//  Created by Nihad Ismayilov on 13.09.22.
//

import Foundation
import domain
import Promises

public class ExploreViewModel {
    
    private let getSearchNewsUseCase: GetSearchNewsUseCase
    
    public init(getSearchNewsUseCase: GetSearchNewsUseCase) {
        self.getSearchNewsUseCase = getSearchNewsUseCase
    }
    
    func getSearchNews(with query: String) -> Promise<SearchNews> {
        return getSearchNewsUseCase.execute(with: query)
    }
}
