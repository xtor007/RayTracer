//
//  ContrastViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.03.2023.
//

import Foundation

final class ContrastViewport: Viewport {
    
    func display(frame: Frame<Float>) {
        
        for x in 0..<frame.width {
            for y in 0..<frame.height {
                print(frame[x, y] == 0 ? "⬛️" : "⬜️", terminator: "")
            }
            print()
        }
    }
    
}
