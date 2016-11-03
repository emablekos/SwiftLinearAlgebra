//
//  LinearSystemTests.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 11/3/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import XCTest

class LinearSystemTests : XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testMutations() {

        let s = LinearSystem([
            Plane(A:1, B:1, C:1, k:1),
            Plane(A:2, B:0, C:2, k:2),
            Plane(A:0, B:3, C:3, k:3),
            ]);

        s.swapRows(2, 0);
        XCTAssertEqualWithAccuracy(s[0].constant, 3.0, accuracy: DBL_EPSILON);
        XCTAssertEqualWithAccuracy(s[1].constant, 2.0, accuracy: DBL_EPSILON);
        XCTAssertEqualWithAccuracy(s[2].constant, 1.0, accuracy: DBL_EPSILON);

        s.multiplyRow(1, by: 2.5);
        XCTAssert(s[1].normal.isEqual(to: Vector(5,0,5)));
        XCTAssertEqualWithAccuracy(s[1].constant, 5.0, accuracy: DBL_EPSILON);

        s.addRow(0, to: 2, multiplier: -10);
        XCTAssert(s[2].normal.isEqual(to: Vector(1,-29,-29)));
        XCTAssertEqualWithAccuracy(s[2].constant, -29, accuracy: DBL_EPSILON);
    }
}
