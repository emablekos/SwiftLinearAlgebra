//
//  LineTests.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/31/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import XCTest

class LineTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testInit() {
        var l = Line(normal: Vector(3.549,2), constant: 5);
        XCTAssertEqual(l.description, "3.55x0 + 2x1 = 5");

        l = Line(normal: Vector(0,-2), constant: 5);
        XCTAssertEqual(l.description, "- 2x1 = 5");

        l = Line(normal: Vector(2,3), constant: 6);
        XCTAssert(Vector(3,0).isEqual(to: l.basepoint));
    }

    func testParallel() {
        var l1 = Line(A:3, B:-2, k:1);
        var l2 = Line(A:-6, B:4, k:0);

        XCTAssertTrue(Line.parallel(a: l1, b: l2));

        l1 = Line(A:1, B:2, k:3);
        l2 = Line(A:1, B:-1, k:2);

        XCTAssertFalse(Line.parallel(a: l1, b: l2));
    }

    func testEqual() {
        var l1 = Line(A:3, B:2, k:1);
        var l2 = Line(A:6, B:4, k:2);
        XCTAssertTrue(l1.isEqual(to: l2));

        l1 = Line(A:3, B:-2, k:1);
        l2 = Line(A:-6, B:4, k:0);
        XCTAssertFalse(l1.isEqual(to: l2));
    }

    func testIntersection() {
        let l1 = Line(A:7.204, B:3.182, k:8.68);
        let l2 = Line(A:8.172, B:4.114, k:9.883);

        let v = Vector(1.1727766354646414, 0.072695511663331838);
        XCTAssertEqual(Line.intersection(a: l1, b: l2), v);
    }
}
