//
//  Pixel.swift
//  
//
//  Created by Illia Kniaziev on 26.03.2023.
//

import Foundation

public typealias Matrix = [[Pixel]]

public struct Pixel {
    
    /// red chanel value from 0 to 1
    let red: Float
    
    /// green chanel value from 0 to 1
    let green: Float
    
    /// blue chanel value from 0 to 1
    let blue: Float
    
}

public extension Pixel {
    
    /// Constructor accepts chanel values in range from 0 to 255
    /// - Parameters:
    ///   - red: red chanel value from 0 to 255
    ///   - green: green chanel value from 0 to 255
    ///   - blue: blue chanel value from 0 to 255
    init(red255 red: Int, green: Int, blue: Int) {
        self.init(red: Float(red) / 255, green: Float(green) / 255, blue: Float(blue) / 255)
    }
    
}
