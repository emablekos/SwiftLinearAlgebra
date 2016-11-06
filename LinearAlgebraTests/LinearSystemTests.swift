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

    func testSolutions() {
        var s: LinearSystem;
        var i: Intersection;

        s = LinearSystem([
            Plane(A: 5.862, B: 1.178, C: -10.366, k: -8.15),
            Plane(A:-2.931, B:-0.589, C: 5.183, k:-4.075)
            ]);
        i = s.computeRREF();
        XCTAssertEqual(i.kind, Intersection.Kind.none);

        

        s = LinearSystem([
            Plane(A: 5.262, B: 2.739, C: -9.878, k: -3.441),
            Plane(A: 5.111, B: 6.358, C: 7.638, k: -2.152),
            Plane(A: 2.016, B: -9.924, C: -1.367, k: -9.278),
            Plane(A: 2.167, B:-13.543, C:-18.883, k:-10.567)
            ]);
        i = s.computeRREF();
        XCTAssertEqual(i.kind, Intersection.Kind.vector);
        let v = i.value as! Vector
        XCTAssertEqualWithAccuracy(v[0], -1.177, accuracy:0.001);
        XCTAssertEqualWithAccuracy(v[1], 0.707, accuracy:0.001);
        XCTAssertEqualWithAccuracy(v[2], -0.083, accuracy:0.001);



        s = LinearSystem([
            Plane(A: 0.786, B: 0.786, C: 0.588, k: -0.714),
            Plane(A: -0.131, B: -0.131, C: 0.244, k: 0.319)
            ]);
        i = s.computeRREF();
        XCTAssertEqual(i.kind, Intersection.Kind.parameters)
        var a = i.value as! [Vector];
        XCTAssert(a[0].isEqual(to: Vector(-1.346, 0.0, 0.585), precision: 0.001));
        XCTAssert(a[1].isEqual(to: Vector(-1,1,0), precision: 0.001));

        s = LinearSystem([
            Plane(A: 8.631, B: 5.112, C: -1.816, k: -5.113),
            Plane(A: 4.315, B: 11.132, C: -5.27, k: -6.775),
            Plane(A: -2.158, B: 3.01, C: -1.727, k: -0.831)
            ]);
        i = s.computeRREF();
        XCTAssertEqual(i.kind, Intersection.Kind.parameters)
        a = i.value as! [Vector];
        XCTAssert(a[0].isEqual(to: Vector(-0.301, -0.492, 0.0), precision:0.001));
        XCTAssert(a[1].isEqual(to: Vector(-0.091, 0.509, 1.0), precision:0.001));

        s = LinearSystem([
            Plane(A: 0.935, B: 1.76, C: -9.365, k: -9.955),
            Plane(A: 0.187, B: 0.352, C: -1.873, k: -1.991),
            Plane(A: 0.374, B: 0.704, C: -3.746, k: -3.982),
            Plane(A: -0.561, B: -1.056, C: 5.619, k: 5.973)
            ]);
        i = s.computeRREF();
        XCTAssertEqual(i.kind, Intersection.Kind.parameters)
        a = i.value as! [Vector];
        XCTAssert(a[0].isEqual(to: Vector(-10.647, 0, 0), precision:0.001));
        XCTAssert(a[1].isEqual(to: Vector(-1.882, 1, 0), precision:0.001));
        XCTAssert(a[2].isEqual(to: Vector(10.016, 0, 1), precision:0.001));



    }


}
