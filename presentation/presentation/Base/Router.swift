//
//  Router.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Swinject

public protocol RouterProtocol {
    func homeVC() -> HomeVC
}

public class Router: RouterProtocol {
    private let resolver: Resolver
    
    public init(
        resolver: Resolver
    ) {
        self.resolver = resolver
    }
    
    public func tabbarVC() -> TabbarVC {
        let vc = TabbarVC()
        return vc
    }
    
    public func homeVC() -> HomeVC {
        let vc = HomeVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
}
