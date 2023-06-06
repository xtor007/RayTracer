//
//  Frame.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.03.2023.
//

import Foundation

struct Frame<T> {
    
    typealias Matrix = ContiguousArray<ContiguousArray<T>>
    
    let width: Int
    let height: Int
    
    private(set) var matrix: Matrix
    
    init(width: Int, height: Int, defaultValue: T) {
        self.width = width
        self.height = height
        
        var matrix = Matrix()
        (0..<height).forEach { _ in
            matrix.append(ContiguousArray<T>(repeating: defaultValue, count: width))
        }
        self.matrix = matrix
    }
    
    subscript(x: Int, y: Int) -> T {
        get {
            return matrix[y][x]
        }
        set(newValue) {
            
            matrix[y][x] = newValue
        }
    }
    
    subscript(x: Int) -> ContiguousArray<T> {
        get {
            return matrix[x]
        }
        set (newValue) {
            matrix[x] = newValue
        }
    }
    
    subscript(safeX x: Int, y: Int) -> T? {
        get {
            matrix[safe: y]?[safe: x]
        }
    }
    
}
