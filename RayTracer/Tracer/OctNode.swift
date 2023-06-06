//
//  OctNode.swift
//  RayTracer
//
//  Created by Anatoliy Khramchenko on 05.06.2023.
//

import Foundation

class OctNode {
    
    private var objects = [Object3D]()
    private var children = [OctNode]()
    
    let leftDownPoint: Point3D
    let rightUpPoint: Point3D
    
    init(leftDownPoint: Point3D, rightUpPoint: Point3D) {
        self.leftDownPoint = leftDownPoint
        self.rightUpPoint = rightUpPoint
    }
    
    func addObject(_ object: Object3D) {
        if children.isEmpty {
            generateChildren()
        }
        var isAdded = false
        children.forEach { child in
            if object.isFullInCube(leftDownPoint: child.leftDownPoint, rightUpPoint: child.rightUpPoint) {
                child.addObject(object)
                isAdded = true
            }
        }
        if !isAdded {
            objects.append(object)
        }
    }
    
    func getIntersections(forRay ray: Ray) -> [(Float, Point3D, Object3D)] {
        var intersections = [(Float, Point3D, Object3D)]()
        objects.forEach { object in
            if let point = object.getIntersectionPoint(forRay: ray) {
                let distance = point.distance(to: ray.startPoint)
                intersections.append((distance, point, object))
            }
        }
        children.forEach { child in
            if child.isIntersected(byRay: ray) {
                intersections += child.getIntersections(forRay: ray)
            }
        }
        return intersections
    }
    
    func isIntersected(byRay ray: Ray) -> Bool {
        let tMin = [
            (leftDownPoint.x - ray.startPoint.x) / ray.vector.x,
            (leftDownPoint.y - ray.startPoint.y) / ray.vector.y,
            (leftDownPoint.z - ray.startPoint.z) / ray.vector.z
        ]
        let tMax = [
            (rightUpPoint.x - ray.startPoint.x) / ray.vector.x,
            (rightUpPoint.y - ray.startPoint.y) / ray.vector.y,
            (rightUpPoint.z - ray.startPoint.z) / ray.vector.z
        ]
        return tMin.max()! <= tMax.min()!
    }
    
    private func generateChildren() {
        let xValues = [leftDownPoint.x, (leftDownPoint.x + rightUpPoint.x) / 2, rightUpPoint.x]
        let yValues = [leftDownPoint.y, (leftDownPoint.y + rightUpPoint.y) / 2, rightUpPoint.y]
        let zValues = [leftDownPoint.z, (leftDownPoint.z + rightUpPoint.z) / 2, rightUpPoint.z]
        for xIndex in 0...1 {
            for yIndex in 0...1 {
                for zIndex in 0...1 {
                    children.append(OctNode(
                        leftDownPoint: Point3D(x: xValues[xIndex], y: yValues[yIndex], z: zValues[zIndex]),
                        rightUpPoint: Point3D(x: xValues[xIndex + 1], y: yValues[yIndex + 1], z: zValues[zIndex + 1])
                    ))
                }
            }
        }
    }
    
}
