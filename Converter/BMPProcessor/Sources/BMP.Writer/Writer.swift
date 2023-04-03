//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import Foundation
import PluginInterface
import BMP_Core

final class TestPlugin: WriterPlugin {
    
    override var supportedFileType: String { "bmp" }
    
    override func write(matrix: Matrix) -> Data {
        let height = matrix.count
        guard let width = matrix.first?.count else { return Data() }
        
        var data = Data()
        var header = BMPHeader()
        header.fileType = "BM"
        header.fileSize = BMPHeader.size + BMPInfoHeader.size + UInt32(height) * UInt32(width) * 3
        header.pixelDataOffset = BMPHeader.size + BMPInfoHeader.size
        data.append(header.data)
        
        var infoHeader = BMPInfoHeader()
        infoHeader.headerSize = BMPInfoHeader.size
        infoHeader.imageWidth = Int32(width)
        infoHeader.imageHeight = Int32(height)
        infoHeader.numColorPlanes = 1
        infoHeader.bitsPerPixel = 24
        infoHeader.compressionMethod = 0
        infoHeader.imageSize = UInt32(height * width * 3)
        infoHeader.horizontalResolution = 0
        infoHeader.verticalResolution = 0
        infoHeader.numColorsInPalette = 0
        infoHeader.numImportantColors = 0
        data.append(infoHeader.data)
        
        var pixelData = Data()
        let padding = Int((4 - (infoHeader.imageWidth * 3) % 4) % 4)
        
        for y in 0..<height {
            for x in 0..<width {
                let pixel = matrix[y][x]
                pixelData.append(contentsOf: [pixel.red, pixel.green, pixel.blue])
            }
            pixelData.append(contentsOf: [UInt8](repeating: 0, count: padding))
        }
        
        data.append(pixelData)
        
        return data
    }
    
}

final class TestPluginBuilder: PluginBuilder<WriterPlugin> {
    override func build() -> WriterPlugin {
        TestPlugin()
    }
}

@_cdecl("writerPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(TestPluginBuilder()).toOpaque()
}
