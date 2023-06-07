//
//  ConsoleViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.03.2023.
//

import Foundation

final class ConsoleViewport: Viewport {
    
    private enum IlluminationCharacter: String, CustomStringConvertible {
        
        case dark = " "
        case dim = "."
        case moderate = "*"
        case high = "O"
        case intensive = "#"
        
        var description: String { rawValue }
        
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
    
    func display(frame: Frame<Float>) {
        for x in 0..<frame.width {
            for y in 0..<frame.height {
                print(IlluminationCharacter(lightIntensivity: frame[x, y]), terminator: "")
            }
            print()
        }
    }
    
}
