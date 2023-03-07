//
//  ContrastViewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.03.2023.
//

import Foundation

final class ContrastViewport: Viewport {
    
    private let frame: Frame<Float>
    
    init(frame: Frame<Float>) {
        self.frame = frame
    }
    
    func display() {
        
        for x in 0..<frame.width {
            for y in 0..<frame.height {
                print(frame[x, y] == 0 ? "⬛️" : "⬜️", terminator: "")
            }
            print()
        }
    }
    
}
