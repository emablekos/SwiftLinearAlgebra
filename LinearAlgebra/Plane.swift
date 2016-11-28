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

        dimension = normal.dimension;

        self.normal = normal;
        self.constant = constant;

        self.basepoint = Line.basepointFrom(normal: normal, constant: constant);
    }
    
    var description: String {
        return Line.equationDescription(normal: self.normal, constant: self.constant);
    }

    func isParallel(to: Plane) -> Bool {
        // Two lines are parallel if their normals are parallel
        return Vector.parallel(self.normal, to.normal)
    }

    func isEqual(to: Plane, precision: Double = DBL_EPSILON * 1000) -> Bool {

        if self.normal.isZero() {
            if to.normal.isZero() {
                // If both normals are zero and the constants are equal, the lines are equal
                return self.constant.isEqual(circa: to.constant);
            } else {
                return false;
            }
        } else if to.normal.isZero() { // && !self.isZero()
            return false;
        }

        // Just check if they are parallel
        if !self.isParallel(to: to){
            return false;
        }

        // Find the vector between both planes basepoints
        let v = to.basepoint - self.basepoint;

        // If orthogonal to our normal then planes are parallel
        let b = Vector.orthogonal(v, self.normal, precision: precision);
        
        return b;
    }

    static func firstNonZeroIndex(_ coords: [Double]) -> Int {
        for (i, c) in coords.enumerated() {
            if (!c.isEqual(to: 0.0)) {
                return i;
            }
        }
        return NSNotFound;
    }


}
