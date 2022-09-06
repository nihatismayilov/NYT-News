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
            return HomeViewModel(getPopularnewsUseCase: r.resolve(GetPopularNewsUseCase.self)!)
        }
    }
}
