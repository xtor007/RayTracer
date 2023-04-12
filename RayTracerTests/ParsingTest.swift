//
//  ParsingTests.swift
//  RayTracerTests
//
//  Created by Illia Kniaziev on 12.04.2023.
//

import XCTest

final class ParsingTest: XCTestCase {
    
    func testPointParserValid() throws {
        let input = "v -0.894426 -0.447216 0.000000"
        let expected = Point3D(x: -0.894426, y: -0.447216, z: 0)
        
        let compoents = input.components(separatedBy: .whitespaces)
        let parser = PointObjFieldParser()
        
        let actual = try XCTUnwrap(parser.parse(components: compoents))
        XCTAssertEqual(expected, actual)
    }
    
    func testPointParserInvalid() throws {
        let input = "v -0.894426 -0.447216"
        
        let compoents = input.components(separatedBy: .whitespaces)
        let parser = PointObjFieldParser()
        
        XCTAssertNil(parser.parse(components: compoents))
    }
    
    func testFaceParserValid() throws {
        let input = "f 6//10 22//10 31//10"
        let expected = FaceObjFieldParser.Result(firstPivot: (6, 10), secondPivot: (22, 10), thirdPivot: (31, 10))
        
        let compoents = input.components(separatedBy: .whitespaces)
        let parser = FaceObjFieldParser()

        let actual = try XCTUnwrap(parser.parse(components: compoents))
        XCTAssertEqual(expected, actual)
    }
    
    func testFaceParserInvalid() throws {
        let input = "f 6//10 10 31//10"
        
        let compoents = input.components(separatedBy: .whitespaces)
        let parser = FaceObjFieldParser()
        
        XCTAssertNil(parser.parse(components: compoents))
    }
    
    func testParserValid() throws {
        let input = """
        v 0.0 0.1 0.2
        v 1.2 1.1 1.0
        v -4.6 -5.1 10.2
        
        f 1//0 2//0 3//0
        """
        let expected = Triangle(
            point1: Point3D(x: 0, y: 0.1, z: 0.2),
            point2: Point3D(x: 1.2, y: 1.1, z: 1.0),
            point3: Point3D(x: -4.6, y: -5.1, z: 10.2)
        )
        let expectedCount = 1
        
        let parser = ObjParser(stringData: input)
        let triangles = try XCTUnwrap(parser.getTriangles())
        
        XCTAssertEqual(triangles.count, expectedCount)
        let actual = try XCTUnwrap(triangles.first)
        XCTAssertEqual(actual.point1, expected.point1)
        XCTAssertEqual(actual.point2, expected.point2)
        XCTAssertEqual(actual.point3, expected.point3)
    }
    
    func testParserInvalid() throws {
        let input = """
        v 0.0 0.1 0.2
        v 1.2 1.1 1.0
        vf -4.6 -5.1 11.2
        
        f 1//0 2//0 3//0
        """
        
        let parser = ObjParser(stringData: input)
        
        XCTAssertThrowsError(try parser.getTriangles())
    }
    
}

extension FaceObjFieldParser.Result: Equatable {
    static func == (lhs: FaceObjFieldParser.Result, rhs: FaceObjFieldParser.Result) -> Bool {
        return lhs.firstPivot.pointIndex == rhs.firstPivot.pointIndex
        && lhs.firstPivot.normalIndex == rhs.firstPivot.normalIndex
        && lhs.secondPivot.pointIndex == rhs.secondPivot.pointIndex
        && lhs.secondPivot.normalIndex == rhs.secondPivot.normalIndex
        && lhs.thirdPivot.pointIndex == rhs.thirdPivot.pointIndex
        && lhs.thirdPivot.normalIndex == rhs.thirdPivot.normalIndex
    }
}
