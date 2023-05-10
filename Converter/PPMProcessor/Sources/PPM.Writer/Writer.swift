//
//  Writer.swift
//  
//
//  Created by Anatoliy Khramchenko on 10.05.2023.
//

import Foundation
import PluginInterface

final class PPMWriterPlugin: WriterPlugin {
    
    override var supportedFileType: String { "ppm" }
    
    override func write(matrix: Matrix) -> Data {
        var data = Data()

        let magicNumber = "P6\n"
        data.append(Data(magicNumber.utf8))

        let width = "\(matrix[0].count)"
        let height = "\(matrix.count)"
        let maxValue = "255\n"
        let sizeInfo = width + " " + height + "\n" + maxValue
        data.append(Data(sizeInfo.utf8))

        for row in matrix.reversed() {
            for pixel in row {
                data.append(pixel.blue)
                data.append(pixel.green)
                data.append(pixel.red)
            }
        }

        return data
    }
    
}

final class PPMWriterPluginBuilder: PluginBuilder<WriterPlugin> {
    override func build() -> WriterPlugin {
        PPMWriterPlugin()
    }
}

@_cdecl("writerPlugin")
public func createPlugin() -> UnsafeMutableRawPointer {
    Unmanaged.passRetained(PPMWriterPluginBuilder()).toOpaque()
}
