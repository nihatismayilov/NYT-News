//
//  HomeViewModel.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import domain
import Promises

public class HomeViewModel {

    private let getPopularNewsUseCase: GetPopularNewsUseCase
    private let getCategorizedNewsUseCase: GetGategorizedNewsUseCase
    
    public init(getPopularnewsUseCase: GetPopularNewsUseCase,
                getCategorizedNewsUseCase: GetGategorizedNewsUseCase) {
        self.getPopularNewsUseCase = getPopularnewsUseCase
        self.getCategorizedNewsUseCase = getCategorizedNewsUseCase
    }
    
    func getPopularNews() -> Promise<PopularNews> {
        return getPopularNewsUseCase.execute()
    }
    
    func getCategorizedNews(with category: String) -> Promise<CategorizedNews> {
        return getCategorizedNewsUseCase.execute(with: category)
    }
    
}
