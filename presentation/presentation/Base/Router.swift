//
//  Router.swift
//  presentation
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Swinject
import domain
import UIKit

public protocol RouterProtocol {
    func homeVC() -> HomeVC
    func exploreVC() -> ExploreVC
    func saveVC() -> SaveVC
    func profileVC() -> ProfileVC
    func tabbarVC() -> TabbarVC
}
public class Router: RouterProtocol {
    private let resolver: Resolver
    
    public init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    public func tabbarVC() -> TabbarVC {
        let tabbar = TabbarVC(
            vm: resolver.resolve(HomeViewModel.self)!,
            router: self
        )
        return tabbar
    }
    
    public func homeVC() -> HomeVC {
        let vc = HomeVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
    
    public func exploreVC() -> ExploreVC {
        let vc = ExploreVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
    
    public func saveVC() -> SaveVC {
        let vc = SaveVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
    
    public func profileVC() -> ProfileVC {
        let vc = ProfileVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
}
