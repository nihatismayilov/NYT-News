//
//  DomainAssembly.swift
//  domain
//
//  Created by Nihad Ismayilov on 05.09.22.
//

import Foundation
import Swinject

public class DomainAssembly: Assembly {
    public init() { }
    
    public func assemble(container: Container) {
        container.register(GetPopularNewsUseCase.self) { r in
            GetPopularNewsUseCase.init(repo: r.resolve(PopularNewsRepoProtocol.self)!)
        }
    }
}
