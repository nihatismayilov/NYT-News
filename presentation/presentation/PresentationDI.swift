//
//  PresentationDI.swift
//  presentation
//
//  Created by Nihad Ismayilov on 02.09.22.
//

import Foundation
import Swinject
import domain

public class PresentationAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        // MARK: - View models
        
        // MARK: - View controllers
        
//        container.register(HomeVC.self) { r in
//            StartViewController(
//                navProvider: r.resolve(NavigationProviderProtocol.self)!,
//                vm: r.resolve(StartViewModel.self)!)
//        }
        
        // MARK: - View provider
        
        // MARK: - Locale helper
    }
}
