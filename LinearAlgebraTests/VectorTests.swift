//
//  LinearAlgebraTests.swift
//  LinearAlgebraTests
//
//  Created by E.J. Mablekos on 10/26/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import XCTest

class VectorTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testAddition() {
        let a = Vector(1,3);
        let b = Vector(2,1);
        let c = a + b;
        let d = Vector(3,4);
        XCTAssertEqualWithAccuracy(c.x, d.x, accuracy:DBL_EPSILON);
        XCTAssertEqualWithAccuracy(c.y, d.y, accuracy:DBL_EPSILON);
    }

    func testSubtraction() {
        let a = Vector(1,3);
        let b = Vector(2,1);
        let c = a - b;
        let d = Vector(-1,2);
        XCTAssertEqualWithAccuracy(c.x, d.x, accuracy:DBL_EPSILON);
        XCTAssertEqualWithAccuracy(c.y, d.y, accuracy:DBL_EPSILON);
    }

    func testMult() {
        let a: Vector = Vector(1,3);
        let b: Double = 2.0
        let c: Vector = a * b;
        let d = Vector(2,6);
        XCTAssertEqualWithAccuracy(c.x, d.x, accuracy:DBL_EPSILON);
        XCTAssertEqualWithAccuracy(c.y, d.y, accuracy:DBL_EPSILON);
    }

    func testEquality() {
        let a = Vector(3.0,6.0) * 2.0;
        let b = Vector(6.0,12.0);
        XCTAssertTrue(a==b);

        XCTAssertTrue(Vector(0,0,0).isZero());
    }

    func testMagnitude() {
        let a = Vector(3,4);
        XCTAssertEqualWithAccuracy(a.magnitude(), 5.0, accuracy:DBL_EPSILON);
    }

    func testNormalize() {
        let a = Vector(3,1,2);
        let b = a.normalize();
        let c = Vector(0.802, 0.267, 0.534);
        XCTAssertEqualWithAccuracy(b.x, c.x, accuracy:0.001);
        XCTAssertEqualWithAccuracy(b.y, c.y, accuracy:0.001);
        XCTAssertEqualWithAccuracy(b.z, c.z, accuracy:0.001);

    }

    func testDotProduct() {
        let a = Vector(1,2,1);
        let b = Vector(3,1,0);
        XCTAssertEqualWithAccuracy(a*b, 5, accuracy: DBL_EPSILON);
        XCTAssertEqualWithAccuracy(Vector.theta(a, b), 0.87, accuracy: 0.01);
    }

    func testParallel() {
        var a = Vector(1,1);
        var b = Vector(-5.2,-5.2);
        XCTAssertTrue(Vector.parallel(a, b));

        a = Vector(10000,0);
        b = Vector(1,0);
        XCTAssertTrue(Vector.parallel(a, b));

        a = Vector(0,1)
        b = Vector(1,0);
        XCTAssertTrue(Vector.orthogonal(a, b));

        a = Vector(1,1)
        b = Vector(-1000,1000);
        XCTAssertTrue(Vector.orthogonal(a, b));

        a = Vector(5,1);
        b = Vector(5,4);
        XCTAssertFalse(Vector.parallel(a, b));
        XCTAssertFalse(Vector.orthogonal(a, b));

    }

    func testProjection() {
        var a = Vector(1,2);
        var b = Vector(3,4);

        var c = Vector(1.32,1.76);
        var d = a.projection(onto: b);
        XCTAssertEqual(d, c);

        a = Vector([3.009, -6.172, 3.692, -2.51]);
        b = Vector([6.404, -9.144, 2.759, 8.718]);

        c = Vector([1.96851616, -2.81076074, 0.84808496, 2.67981323]);
        d = Vector([1.04048383, -3.36123925, 2.84391503, -5.18981323]);
        XCTAssert(a.projection(onto: b).isEqual(to: c, precision: 0.00001));
        XCTAssert(a.component(orthogonalTo: b).isEqual(to: d, precision: 0.00001));
    }

    func testCross() {

        let a = Vector(5,3,-2);
        let b = Vector(-1,0,3)

        let c = Vector(9,-13,3);
        let d: Vector = a * b;

        XCTAssertEqual(d, c);

        let area: Double = Vector.areaOfParallelogram(a,b);
        XCTAssertEqualWithAccuracy(area, 16.093, accuracy: 0.001);
    }

}
