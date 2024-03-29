//
//  Line.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/29/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation

struct Line : CustomStringConvertible {

    let normal: Vector;
    let constant: Double;
    let basepoint: Vector;

    init(A: Double, B: Double, k: Double) {
        self.init(normal: Vector(A,B), constant: k);
    }

    init(normal: Vector, constant: Double) {
        self.normal = normal;
        self.constant = constant;

        self.basepoint = Line.basepointFrom(normal: normal, constant: constant);
    }

    static func basepointFrom(normal: Vector, constant: Double) -> Vector {
        if normal.isZero() {
            return normal;
        }

        var arr = [Double](repeating:0.0, count:normal.dimension);

        let i = Line.firstNonZeroIndex(normal.coordinates);
        let c = normal.coordinates[i];

        arr[i] = constant/c;

        return Vector(arr);
    }

    static func firstNonZeroIndex(_ coords: [Double]) -> Int {
        for (i, c) in coords.enumerated() {
            if (!c.isEqual(to: 0.0)) {
                return i;
            }
        }
        return NSNotFound;
    }

    func isParallel(to: Line) -> Bool {
        // Two lines are parallel if their normals are parallel
        return Vector.parallel(self.normal, to.normal)
    }

    func intersect(with: Line) -> Intersection {
        var lines = [self,with];

        // If our first line has zero in the first parameter, flip the order so our equation works
        if lines.first!.normal.x.isEqual(circa: 0.0) {
            let l = lines.last!;
            lines.removeLast();
            lines.insert(l, at: 0);
        }

        if lines.first!.normal.x.isEqual(circa: 0.0) {
            print("Both lines have zero in first parameter, therefore are horizontal and parallel");
            return Intersection();
        }

        var A,B,C,D,k1,k2,x,y: Double;

        // Set up parameters
        A = lines.first!.normal.x;
        B = lines.first!.normal.y;
        k1 = lines.first!.constant;

        C = lines.last!.normal.x;
        D = lines.last!.normal.y;
        k2 = lines.last!.constant;

        // Known formula for solving intersections
        let denom = A*D - B*C
        if denom.isEqual(circa: 0.0) {
            print("Parallel lines");
            return Intersection();
        }

        x = (D*k1 - B*k2)/denom;
        y = (-C*k1 + A*k2)/denom;

        return Intersection(Vector(x,y));
    }

    func isEqual(to: Line, precision: Double = DBL_EPSILON * 1000) -> Bool {

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
        if !self.isParallel(to: to) {
            return false;
        }

        // Find the vector between both lines basepoints
        let v = to.basepoint - self.basepoint;

        // If orthogonal to our normal then lines are parallel
        let b = Vector.orthogonal(v, self.normal, precision: precision);

        return b;
    }

    var description: String {
        return Line.equationDescription(normal: self.normal, constant: self.constant);
    }

    static func equationDescription(normal: Vector, constant: Double) -> String {
        let str: NSMutableString = NSMutableString();
        for (i, c) in normal.coordinates.enumerated() {
            if (abs(c) > DBL_EPSILON) {
                let isfirst = str.length == 0
                if !isfirst {
                    str.append(" ")
                }

                if c < 0 {
                    str.append("- ")
                } else if c > 0 && !isfirst {
                    str.append("+ ")
                }

                if abs(c.truncatingRemainder(dividingBy: 1.0)) > 0.001 {
                    str.appendFormat("%.02f", abs(c))
                } else {
                    str.appendFormat("%.f", abs(c))
                }

                str.appendFormat("x%i", i)
            }
        }

        if abs(constant.truncatingRemainder(dividingBy: 1.0)) > 0.001 {
            str.appendFormat(" = %.02f", constant)
        } else {
            str.appendFormat(" = %.f", constant)
        }
        
        return str.copy() as! String
    }
}
