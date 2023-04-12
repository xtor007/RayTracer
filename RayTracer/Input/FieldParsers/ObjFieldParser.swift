//
//  ObjFieldParser.swift
//  RayTracer
//
//  Created by Illia Kniaziev on 12.04.2023.
//

import Foundation

typealias StringComponents = [String]

protocol ObjFieldParser {
    
    associatedtype Result
    
    func parse(components: StringComponents) -> Result?
    
}
