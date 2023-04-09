//
//  ImageCreator.swift
//  
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import ConverterCore
import Foundation
import PluginInterface

public final class ImageCreator {
    
    enum ImageCreationError: Error {
        case noWriterFound
    }
    
    private let libsFactory = LibsFactory()
    
    public init() {}
    
    public func createImage(fromBitmap matrix: Matrix, usingName name: String, withExtension aExtension: String) throws {
        let destinationPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            .appending(path: name)
            .appendingPathExtension(aExtension)
        
        guard let writer = try libsFactory.getWriter(forExtension: aExtension) else {
            throw ImageCreationError.noWriterFound
        }
        
        let destData = writer.write(matrix: matrix)
        try destData.write(to: destinationPath)
    }
    
}
