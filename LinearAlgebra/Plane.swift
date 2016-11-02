//
//  Plane.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 11/1/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation

struct Plane : CustomStringConvertible {

    let normal: Vector;
    let constant: Double;
    let basepoint: Vector;
    let dimension: Int;

    init(A: Double, B: Double, C: Double, k: Double) {
        self.init(normal: Vector(A,B,C), constant: k);
    }

    init(normal: Vector, constant: Double) {
        assert(!normal.isZero());

        dimension = normal.dimension;

        self.normal = normal;
        self.constant = constant;

        self.basepoint = Line.basepointFrom(normal: normal, constant: constant);
    }
    
    var description: String {
        return Line.equationDescription(normal: self.normal, constant: self.constant);
    }

    static func parallel(a: Plane, b: Plane) -> Bool {
        // Two lines are parallel if their normals are parallel
        return Vector.parallel(a.normal, b.normal)
    }

    func isEqual(to: Plane, precision: Double = DBL_EPSILON) -> Bool {

        if self.normal.isZero() {
            if to.normal.isZero() {
                // If both normals are zero and the constants are equal, the lines are equal
                return self.constant.isEqual(to: to.constant);
            } else {
                return false;
            }
        } else if to.normal.isZero() { // && !self.isZero()
            return false;
        }

        // Just check if they are parallel
        if !Plane.parallel(a: self, b: to) {
            return false;
        }

        // Find the vector between both lines basepoints
        let v = to.basepoint - self.basepoint;

        // If orthogonal to our normal then lines are parallel
        let b = Vector.orthogonal(v, self.normal, precision: precision);
        
        return b;
    }


}
