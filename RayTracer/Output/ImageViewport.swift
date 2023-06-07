//
//  ImageViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import ImageCreator
import PluginInterface

final class ImageViewport: Viewport {

    func display(frame: Frame<Pixel>) {
        let bitmap: PluginInterface.Matrix = frame.matrix
            .map { row in
                row.map { PluginInterface.Pixel(red: $0.red, green: $0.green, blue: $0.blue) }
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
