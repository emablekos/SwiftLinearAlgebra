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

        var s = LinearSystem([
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


    func testTriangularForm() {
        var s,t: LinearSystem;
        //
        s = LinearSystem([
            Plane(A:1, B:1, C:1, k:1),
            Plane(A:0, B:1, C:1, k:2)
            ]);
        t = s;
        _ = t.computeTriangularForm();
        XCTAssert(t[0].isEqual(to: s[0]));
        XCTAssert(t[1].isEqual(to: s[1]));

        //
        s = LinearSystem([
            Plane(A:1, B:1, C:1, k:1),
            Plane(A:1, B:1, C:1, k:2)
            ]);
        t = s;
        _ = t.computeTriangularForm();
        XCTAssert(t[0].isEqual(to: s[0]));
        XCTAssert(t[1].isEqual(to: Plane(A: 0, B: 0, C: 0, k: 1)));

        //
        s = LinearSystem([
            Plane(A:1, B:1, C: 1, k:1),
            Plane(A:0, B:1, C: 0, k:2),
            Plane(A:1, B:1, C:-1, k:3),
            Plane(A:1, B:0, C:-2, k:2)
            ]);
        t = s;
        _ = t.computeTriangularForm();
        XCTAssert(t[0].isEqual(to: s[0]));
        XCTAssert(t[1].isEqual(to: s[1]));
        XCTAssert(t[2].isEqual(to: Plane(A: 0, B: 0, C:-2, k: 2)));
        XCTAssert(t[3].isEqual(to: Plane(A: 0, B: 0, C: 0, k: 0)));

        //
        s = LinearSystem([
            Plane(A:0, B: 1, C: 1, k:1),
            Plane(A:1, B:-1, C: 1, k:2),
            Plane(A:1, B: 2, C:-5, k:3)
            ]);
        t = s;
        _ = t.computeTriangularForm();
        XCTAssert(t[0].isEqual(to: Plane(A: 1, B:-1, C: 1, k: 2)));
        XCTAssert(t[1].isEqual(to: Plane(A: 0, B: 1, C: 1, k: 1)));
        XCTAssert(t[2].isEqual(to: Plane(A: 0, B: 0, C:-9, k:-2)));

    }

    func testRREF() {
        var s,r: LinearSystem;
        var res: LinearSystem.TriangularFormResult;

        s = LinearSystem([
            Plane(A:1, B: 1, C: 1, k:1),
            Plane(A:0, B: 1, C: 1, k:2)
            ]);
        r = s;
        _ = r.computeRREF();
        XCTAssert(r[0].isEqual(to: Plane(A: 1, B:0, C: 0, k: -1)));
        XCTAssert(r[1].isEqual(to: s[1]));


        s = LinearSystem([
            Plane(A:1, B: 1, C: 1, k:1),
            Plane(A:1, B: 1, C: 1, k:2)
            ]);
        r = s;
        _ = r.computeRREF();
        XCTAssert(r[0].isEqual(to: s[0]));
        XCTAssert(r[1].isEqual(to: Plane(A: 0, B: 0, C: 0, k: 1)));


        s = LinearSystem([
            Plane(A: 1, B: 1, C: 1, k: 1),
            Plane(A: 0, B: 1, C: 0, k: 2),
            Plane(A: 1, B: 1, C: -1, k: 3),
            Plane(A: 1, B: 0, C: -2, k: 2)
            ]);
        r = s;
        _ = r.computeRREF();
        XCTAssert(r[0].isEqual(to: Plane(A: 1, B: 0, C: 0, k: 0)));
        XCTAssert(r[1].isEqual(to: s[1]));
        XCTAssert(r[2].isEqual(to: Plane(A: 0, B: 0, C:-2, k: 2)));
        XCTAssert(r[3].isEqual(to: Plane(A: 0, B: 0, C: 0, k: 0)));

        s = LinearSystem([
            Plane(A: 0, B: 1, C: 1, k: 1),
            Plane(A: 1, B: -1, C: 1, k: 2),
            Plane(A: 1, B: 2, C: -5, k: 3)
            ]);
        r = s;
        _ = r.computeRREF();
        XCTAssert(r[0].isEqual(to: Plane(A: 1, B: 0, C: 0, k: 23/9)));
        XCTAssert(r[1].isEqual(to: Plane(A: 0, B: 1, C: 0, k: 7/9)));
        XCTAssert(r[2].isEqual(to: Plane(A: 0, B: 0, C: 1, k: 2/9)));

    }


}
