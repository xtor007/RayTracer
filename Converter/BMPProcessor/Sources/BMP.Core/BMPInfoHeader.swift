//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import Foundation

public struct BMPInfoHeader {
    
    public static let size: UInt32 = 40
    
    public var headerSize: UInt32 = 0
    public var imageWidth: Int32 = 0
    public var imageHeight: Int32 = 0
    public var numColorPlanes: UInt16 = 0
    public var bitsPerPixel: UInt16 = 0
    public var compressionMethod: UInt32 = 0
    public var imageSize: UInt32 = 0
    public var horizontalResolution: Int32 = 0
    public var verticalResolution: Int32 = 0
    public var numColorsInPalette: UInt32 = 0
    public var numImportantColors: UInt32 = 0
    
    public init(
        headerSize: UInt32 = 0,
        imageWidth: Int32 = 0,
        imageHeight: Int32 = 0,
        numColorPlanes: UInt16 = 0,
        bitsPerPixel: UInt16 = 0,
        compressionMethod: UInt32 = 0,
        imageSize: UInt32 = 0,
        horizontalResolution: Int32 = 0,
        verticalResolution: Int32 = 0,
        numColorsInPalette: UInt32 = 0,
        numImportantColors: UInt32 = 0
    ) {
        self.headerSize = headerSize
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.numColorPlanes = numColorPlanes
        self.bitsPerPixel = bitsPerPixel
        self.compressionMethod = compressionMethod
        self.imageSize = imageSize
        self.horizontalResolution = horizontalResolution
        self.verticalResolution = verticalResolution
        self.numColorsInPalette = numColorsInPalette
        self.numImportantColors = numImportantColors
    }
    
}

public extension BMPInfoHeader {
    
    var data: Data {
        var data = Data()
        
        var headerSize = headerSize
        data.append(Data(bytes: &headerSize, count: MemoryLayout.size(ofValue: headerSize)))
        
        var imageWidth = imageWidth
        data.append(Data(bytes: &imageWidth, count: MemoryLayout.size(ofValue: imageWidth)))
        
        var imageHeight = imageHeight
        data.append(Data(bytes: &imageHeight, count: MemoryLayout.size(ofValue: imageHeight)))
        
        var numColorPlanes = numColorPlanes
        data.append(Data(bytes: &numColorPlanes, count: MemoryLayout.size(ofValue: numColorPlanes)))
        
        var bitsPerPixel = bitsPerPixel
        data.append(Data(bytes: &bitsPerPixel, count: MemoryLayout.size(ofValue: bitsPerPixel)))
        
        var compressionMethod = compressionMethod
        data.append(Data(bytes: &compressionMethod, count: MemoryLayout.size(ofValue: compressionMethod)))
        
        var imageSize = imageSize
        data.append(Data(bytes: &imageSize, count: MemoryLayout.size(ofValue: imageSize)))
        
        var horizontalResolution = horizontalResolution
        data.append(Data(bytes: &horizontalResolution, count: MemoryLayout.size(ofValue: horizontalResolution)))
        
        var verticalResolution = verticalResolution
        data.append(Data(bytes: &verticalResolution, count: MemoryLayout.size(ofValue: verticalResolution)))
        
        var numColorsInPalette = numColorsInPalette
        data.append(Data(bytes: &numColorsInPalette, count: MemoryLayout.size(ofValue: numColorsInPalette)))
        
        var numImportantColors = numImportantColors
        data.append(Data(bytes: &numImportantColors, count: MemoryLayout.size(ofValue: numImportantColors)))
        
        return data
    }
    
}
