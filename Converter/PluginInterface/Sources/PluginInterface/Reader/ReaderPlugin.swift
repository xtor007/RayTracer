//
//  ReaderPlugin.swift
//  
//
//  Created by Illia Kniaziev on 26.03.2023.
//

import Foundation

open class ReaderPlugin: FilePlugin {
    
    public init() {}
    
    open var supportedFileType: String {
        preconditionFailure("Property not implemented")
    }
    
    open func validate(data: Data) -> Bool {
        preconditionFailure("Method is not implemented")
    }
    
    open func read(data: Data) -> Matrix {
        preconditionFailure("Method is not implemented")
    }
    
}
