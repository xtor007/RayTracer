//
//  ImageViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import ImageCreator
import PluginInterface

final class ImageViewport: Viewport {
    
    private let frame: Frame<Float>
    
    init(frame: Frame<Float>) {
        self.frame = frame
    }
    
    func display() {
        let bitmap: PluginInterface.Matrix = frame.matrix
            .map { row in
                row.map { Pixel(repeatingValue: UInt8(max(Float(UInt8.max) * $0, 0))) }
            }
        
        let imageCreator = ImageCreator()
        try! imageCreator.createImage(fromBitmap: bitmap, usingName: "output", withExtension: "bmp")
    }
    
}

fileprivate extension Pixel {
    
    init(repeatingValue value: UInt8) {
        self.init(red: value, green: value, blue: value)
    }
    
}
