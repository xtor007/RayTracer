//
//  PluginBuilder.swift
//  
//
//  Created by Illia Kniaziev on 27.03.2023.
//

import Foundation

open class PluginBuilder<T> where T: FilePlugin {
    public init() {}
    
    open func build() -> T {
        preconditionFailure("Method is not implemented")
    }
}
