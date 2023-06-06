//
//  Pixel.swift
//  RayTracer
//
//  Created by Yasha Serhiienko on 06.06.2023.
//

import Foundation

struct Pixel: Equatable {
    let red: UInt8
    let green: UInt8
    let blue: UInt8

    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    static func * (left: Float, right: Pixel) -> Pixel {
        return Pixel(
            red: UInt8(left * Float(right.red)),
            green: UInt8(left * Float(right.green)),
            blue: UInt8(left * Float(right.blue))
        )
    }
    
    static func + (left: Pixel, right: Pixel) -> Pixel {
        return Pixel(
            red: UInt8(min(Float(left.red) + Float(right.red), Float(UInt8.max))),
            green: UInt8(min(Float(left.green) + Float(right.green), Float(UInt8.max))),
            blue: UInt8(min(Float(left.blue) + Float(right.blue), Float(UInt8.max)))
        )
    }

}
