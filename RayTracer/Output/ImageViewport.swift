//
//  ImageViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 10.04.2023.
//

import ImageCreator
import PluginInterface

final class ImageViewport: Viewport {
 
    private enum BalckAndWhitePixelType {
        
        case dark
        case dim
        case moderate
        case high
        case intensive
        
        var pixel: Pixel {
            switch self {
            case .dark:
                return Pixel(repeatingValue: 0)
            case .dim:
                return Pixel(repeatingValue: 33)
            case .moderate:
                return Pixel(repeatingValue: 99)
            case .high:
                return Pixel(repeatingValue: 156)
            case .intensive:
                return Pixel(repeatingValue: 230)
            }
        }
        
        init(lightIntensivity: Float) {
            switch lightIntensivity {
            case ...0:
                self = .dark
            case 0..<0.2:
                self = .dim
            case 0.2..<0.5:
                self = .moderate
            case 0.5..<0.8:
                self = .high
            default:
                self = .intensive
            }
        }
        
    }
    
    private let frame: Frame<Float>
    
    init(frame: Frame<Float>) {
        self.frame = frame
    }
    
    func display() {
        let bitmap: PluginInterface.Matrix = frame.matrix
            .map { row in
                row.map { BalckAndWhitePixelType(lightIntensivity: $0).pixel }
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
