//
//  File.swift
//  
//
//  Created by Illia Kniaziev on 02.04.2023.
//

import Foundation
import PluginInterface
import BMP_Core

final class TestPlugin: ReaderPlugin {
    
    override var supportedFileType: String { "bmp" }
    
    override func validate(data: Data) -> Bool {
        let fileTypeData = data.subdata(in: 0..<2)
        let fileType = String(data: fileTypeData, encoding: .ascii) ?? ""
        return fileType == "BM"
    }
    
    override func read(data: Data) -> Matrix {
        var header = BMPHeader()
        var infoHeader = BMPInfoHeader()
        
        let fileTypeData = data.subdata(in: 0..<2)
        header.fileType = String(data: fileTypeData, encoding: .ascii) ?? ""
        header.fileSize = data.subdata(in: 2..<6).withUnsafeBytes { $0.load(as: UInt32.self) }
        header.reserved1 = data.subdata(in: 6..<8).withUnsafeBytes { $0.load(as: UInt16.self) }
        header.reserved2 = data.subdata(in: 8..<10).withUnsafeBytes { $0.load(as: UInt16.self) }
        header.pixelDataOffset = data.subdata(in: 10..<14).withUnsafeBytes { $0.load(as: UInt32.self) }
        
        infoHeader.headerSize = data.subdata(in: 14..<18).withUnsafeBytes { $0.load(as: UInt32.self) }
        infoHeader.imageWidth = data.subdata(in: 18..<22).withUnsafeBytes { $0.load(as: Int32.self) }
        infoHeader.imageHeight = data.subdata(in: 22..<26).withUnsafeBytes { $0.load(as: Int32.self) }
        infoHeader.numColorPlanes = data.subdata(in: 26..<28).withUnsafeBytes { $0.load(as: UInt16.self) }
        infoHeader.bitsPerPixel = data.subdata(in: 28..<30).withUnsafeBytes { $0.load(as: UInt16.self) }
        infoHeader.compressionMethod = data.subdata(in: 30..<34).withUnsafeBytes { $0.load(as: UInt32.self) }
        infoHeader.imageSize = data.subdata(in: 34..<38).withUnsafeBytes { $0.load(as: UInt32.self) }
        infoHeader.horizontalResolution = data.subdata(in: 38..<42).withUnsafeBytes { $0.load(as: Int32.self) }
        infoHeader.verticalResolution = data.subdata(in: 42..<46).withUnsafeBytes { $0.load(as: Int32.self) }
        infoHeader.numColorsInPalette = data.subdata(in: 46..<50).withUnsafeBytes { $0.load(as: UInt32.self) }
        infoHeader.numImportantColors = data.subdata(in: 50..<54).withUnsafeBytes { $0.load(as: UInt32.self) }
        
        guard infoHeader.bitsPerPixel == 24 else { return [] }
        
        let padding = (4 - (infoHeader.imageWidth * 3) % 4) % 4
        let pixelData = data.subdata(in: Int(header.pixelDataOffset)..<data.count)
        var matrix = [[Pixel]]()
        
        for y in 0..<infoHeader.imageHeight {
            var row = [Pixel]()
            for x in 0..<infoHeader.imageWidth {
                let offset = Int(y * (padding + infoHeader.imageWidth * 3) + x * 3)
                let pixel = Pixel(
                    red: pixelData.withUnsafeBytes { $0.load(fromByteOffset: offset, as: UInt8.self) },
                    green: pixelData.withUnsafeBytes { $0.load(fromByteOffset: offset + 1, as: UInt8.self) },
                    blue: pixelData.withUnsafeBytes { $0.load(fromByteOffset: offset + 2, as: UInt8.self) })
                row.append(pixel)
            }
            matrix.append(row)
        }
        
        return matrix
    }
    
}

final class TestPluginBuilder: PluginBuilder<ReaderPlugin> {
    override func build() -> ReaderPlugin {
        TestPlugin()
    }
}

@_cdecl("readerPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(TestPluginBuilder()).toOpaque()
}
