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

// MARK: - Protocol
public protocol RouterProtocol {
    func splashScreenVC() -> SplashScreenVC
    func signInVC() -> SignInVC
    func signUpVC() -> SignUpVC
    
    func tabbarVC() -> TabbarVC
    
    func homeVC() -> HomeVC
    func exploreVC() -> ExploreVC
    func saveVC() -> SaveVC
    func profileVC() -> ProfileVC
    func detailsVC(details: DetailsModel) -> DetailsVC
    func activityVC() -> ActivityVC
    func termsAndConditionsVC() -> TermsAndConditionsVC
    func privacyPolicyVC() -> PrivacyPolicyVC
    func changeModeVC() -> ChangeModeVC
}

// MARK: - Parent
public class Router: RouterProtocol {
    private let resolver: Resolver
    
    public init(resolver: Resolver) {
        self.resolver = resolver
    }
}

// MARK: - LoadScreen
extension Router {
    public func activityVC() -> ActivityVC {
        let vc = ActivityVC()
        return vc
    }
}

// MARK: - Intro
extension Router {
    public func splashScreenVC() -> SplashScreenVC {
        let vc = SplashScreenVC()
        
        vc.router = self
        return vc
    }
}

// MARK: - SignIn & SignUp
extension Router {
    public func signInVC() -> SignInVC {
        let vc = SignInVC()
        vc.vm = resolver.resolve(SignInVM.self)
        vc.router = self
        return vc
    }
    
    public func signUpVC() -> SignUpVC {
        let vc = SignUpVC()
        vc.vm = resolver.resolve(SignUpVM.self)
        vc.router = self
        return vc
    }
}

// MARK: - Tabbar
extension Router {
    public func tabbarVC() -> TabbarVC {
        let tabbar = TabbarVC(
            vm: resolver.resolve(HomeViewModel.self)!,
            router: self
        )
        return tabbar
    }
}

// MARK: - Home
extension Router {
    public func homeVC() -> HomeVC {
        let vc = HomeVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
}

// MARK: - Search
extension Router {
    public func exploreVC() -> ExploreVC {
        let vc = ExploreVC()
        vc.vm = resolver.resolve(ExploreViewModel.self)
        vc.router = self
        return vc
    }
}

// MARK: - Save
extension Router {
    public func saveVC() -> SaveVC {
        let vc = SaveVC()
        vc.vm = resolver.resolve(HomeViewModel.self)
        vc.router = self
        return vc
    }
}

// MARK: - Profile
extension Router {
    public func profileVC() -> ProfileVC {
        let vc = ProfileVC()
        vc.vm = resolver.resolve(ProfileViewModel.self)
        vc.router = self
        return vc
    }
    
    public func termsAndConditionsVC() -> TermsAndConditionsVC {
        let vc = TermsAndConditionsVC()
        vc.router = self
        vc.vm = resolver.resolve(TermsAndConditionsViewModel.self)
        return vc
    }
    
    public func privacyPolicyVC() -> PrivacyPolicyVC {
        let vc = PrivacyPolicyVC()
        vc.router = self
        vc.vm = resolver.resolve(PrivacyPolicyViewModel.self)
        return vc
    }
    
    public func changeModeVC() -> ChangeModeVC {
        let vc = changeModeVC()
        vc.router = self
        vc.vm = resolver.resolve(HomeViewModel.self)
        return vc
    }
}

// MARK: - Details
extension Router {
    public func detailsVC(details: DetailsModel) -> DetailsVC {
        let vc = DetailsVC()
        vc.vm = resolver.resolve(DetailsViewModel.self)
        vc.details = details
        vc.router = self
        return vc
    }
}
