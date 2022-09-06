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

    private let getPopularnewsUseCase: GetPopularNewsUseCase
    public init(getPopularnewsUseCase: GetPopularNewsUseCase) {
        self.getPopularnewsUseCase = getPopularnewsUseCase
    }
    
    func getPopularNews() -> Promise<PopularNews> {
        return getPopularnewsUseCase.execute()
    }
    
}
