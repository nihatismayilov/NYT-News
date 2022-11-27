//
//  PresentationAssembly.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Swinject
import domain


public class PresentationAssembly: Assembly {
    public init () {}
    
    public func assemble(container: Container) {
        container.register(HomeViewModel.self) { r in
            return HomeViewModel(getPopularnewsUseCase: r.resolve(GetPopularNewsUseCase.self)!, getCategorizedNewsUseCase: r.resolve(GetGategorizedNewsUseCase.self)!)
        }
        
        container.register(ExploreViewModel.self) { r in
            return ExploreViewModel(getSearchNewsUseCase: r.resolve(GetSearchNewsUseCase.self)!)
        }
    }
}
