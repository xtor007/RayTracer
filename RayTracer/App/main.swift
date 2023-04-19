//
//  main.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 04.03.2023.
//

import Foundation

let start = Date.timeIntervalSinceReferenceDate
print("Exec path: \(FileManager.default.currentDirectoryPath)\n")

ConsoleRenderer.main()
let end = Date.timeIntervalSinceReferenceDate
print(end - start)

