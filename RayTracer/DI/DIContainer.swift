//
//  DIContainer.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.06.2023.
//

import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    var services: [String: Any] = [:]
    
    func register<Service>(type: Service.Type, service: Any) {
        services["\(type)"] = service
    }
    
    func resolve<Service>(type: Service.Type) -> Service {
        return services["\(type)"] as! Service
    }
}
