//
//  ObjFieldParser.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 12.04.2023.
//

import Foundation

typealias Components = [String]

protocol ObjFieldParser {
    
    associatedtype Result
    
    func parse(components: Components) -> Result?
    
}
