//
//  Viewport.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 07.03.2023.
//

import Foundation

protocol Viewport<T> {
    
    associatedtype T
    
    func display(frame: Frame<T>)
    
}
