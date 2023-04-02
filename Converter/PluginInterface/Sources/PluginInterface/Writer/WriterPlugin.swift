//
//  WriterPlugin.swift
//  
//
//  Created by Illia Kniaziev on 26.03.2023.
//

import Foundation

open class WriterPlugin: FilePlugin {
    
    public init() {}
    
    open var supportedFileType: String {
        preconditionFailure("Property not implemented")
    }
    
    open func write(matrix: Matrix) -> Data {
        preconditionFailure("Method is not implemented")
    }
    
}
