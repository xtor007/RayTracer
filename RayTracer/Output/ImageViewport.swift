//
//  ImageViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import ImageCreator
import PluginInterface

final class ImageViewport: Viewport {
    
    private let frame: Frame<Pixel>
    
    init(frame: Frame<Pixel>) {
        self.frame = frame
    }
    
    func display() {
        let bitmap: PluginInterface.Matrix = frame.matrix
            .map { row in
                row.map { $0 }
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
