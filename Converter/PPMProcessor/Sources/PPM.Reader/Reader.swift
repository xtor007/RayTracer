//
//  Reader.swift
//  
//
//  Created by Anatoliy Khramchenko on 10.05.2023.
//

import Foundation
import PluginInterface

final class PPMReaderPlugin: ReaderPlugin {
    
    override var supportedFileType: String { "ppm" }
    
    override func validate(data: Data) -> Bool {
        guard let magicNumber = String(data: data.prefix(2), encoding: .utf8) else {
            return false
        }
        return magicNumber == "P6" || magicNumber == "P3"
    }
    
    override func read(data: Data) -> Matrix {
        let stringData = String(decoding: data, as: UTF8.self)
        let lines = stringData.split(separator: "\n")

        let magicNumber = String(lines[0])
        let widthHeight = lines[1].split(separator: " ").compactMap { Int($0) }
        let maxColorValue = Int(lines[2]) ?? 255
        let pixels = lines[3..<lines.count]

        var matrix: Matrix = []
        var row: [Pixel] = []

        if magicNumber == "P3" {
            // Text-based PPM file
            for pixelData in pixels {
                let components = pixelData.split(separator: " ").compactMap { Int($0) }
                row = []
                if components.count % 3 == 0 {
                    for pixelIndex in 0..<widthHeight[0] {
                        let pixel = Pixel(red: UInt8(components[3 * pixelIndex + 2]), green: UInt8(components[3 * pixelIndex + 1]), blue: UInt8(components[3 * pixelIndex + 0]))
                        row.append(pixel)
                    }
                }
                if row.count == widthHeight[0] {
                    matrix.insert(row, at: 0)
                    row = []
                }
            }
        } else if magicNumber == "P6" {
            // Binary-based PPM file
            let headerLength = lines[0].utf8.count + lines[1].utf8.count + lines[2].utf8.count + 3
            let headerData = data[0..<headerLength]
            let pixelData = Array(data[headerLength...])
            var pixelDataIndex = 0

            for _ in 0..<widthHeight[1] {
                for _ in 0..<widthHeight[0] {
                    let red = UInt8(pixelData[pixelDataIndex + 2])
                    let green = UInt8(pixelData[pixelDataIndex + 1])
                    let blue = UInt8(pixelData[pixelDataIndex + 0])
                    let pixel = Pixel(red: red, green: green, blue: blue)
                    row.append(pixel)
                    pixelDataIndex += 3
                }
                matrix.insert(row, at: 0)
                row = []
            }
        }

        return matrix
    }
    
}

final class PPMReaderPluginBuilder: PluginBuilder<ReaderPlugin> {
    override func build() -> ReaderPlugin {
        PPMReaderPlugin()
    }
}

@_cdecl("readerPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(PPMReaderPluginBuilder()).toOpaque()
}
