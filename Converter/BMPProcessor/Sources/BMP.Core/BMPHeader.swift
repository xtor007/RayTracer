//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import Foundation

public struct BMPHeader {
    
    public static let size: UInt32 = 14
    
    public var fileType: String = ""
    public var fileSize: UInt32 = 0
    public var reserved1: UInt16 = 0
    public var reserved2: UInt16 = 0
    public var pixelDataOffset: UInt32 = 0
    
    public init(
        fileType: String = "",
        fileSize: UInt32 = 0,
        reserved1: UInt16 = 0,
        reserved2: UInt16 = 0,
        pixelDataOffset: UInt32 = 0
    ) {
        self.fileType = fileType
        self.fileSize = fileSize
        self.reserved1 = reserved1
        self.reserved2 = reserved2
        self.pixelDataOffset = pixelDataOffset
    }
    
}

public extension BMPHeader {
    
    var data: Data {
        var data = Data()
        
        data.append(contentsOf: Array(fileType.utf8))
        
        var fileSize = fileSize
        data.append(Data(bytes: &fileSize, count: MemoryLayout.size(ofValue: fileSize)))
        
        var reserved1 = reserved1
        data.append(Data(bytes: &reserved1, count: MemoryLayout.size(ofValue: reserved1)))
        var reserved2 = reserved2
        data.append(Data(bytes: &reserved2, count: MemoryLayout.size(ofValue: reserved2)))
        
        var pixelDataOffset = pixelDataOffset
        data.append(Data(bytes: &pixelDataOffset, count: MemoryLayout.size(ofValue: pixelDataOffset)))
        
        return data
    }
    
}
