//
//  Vector.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/26/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Cocoa

struct Vector : Equatable {

    var coordinates: [Double] = [];

    var x: Double {
        get {
            return coordinates[0]
        }
        set {
            coordinates[0] = newValue;
        }
    }

    var y: Double {
        get {
            return coordinates[1]
        }
        set {
            coordinates[1] = newValue;
        }
    }

    var z: Double {
        get {
            return coordinates[2]
        }
        set {
            coordinates[2] = newValue;
        }
    }

    init(_ x: Double, _ y: Double) {
        self.coordinates = [x,y];
    }

    init(_ x: Double, _ y: Double, _ z: Double) {
        self.coordinates = [x,y,z];
    }
    init(_ coordinates:[Double]) {
        self.coordinates = coordinates.map{$0};
    }

    static func zero(length: Int) -> Vector {
        let c = [Double](repeating:0.0, count:length);
        return Vector(c);
    }

    static func +(left: Vector, right: Vector) -> Vector {
        let coords = zip(left.coordinates, right.coordinates).map({$0+$1});
        return Vector(coords);
    }

    static func -(left: Vector, right: Vector) -> Vector {
        let coords = zip(left.coordinates, right.coordinates).map({$0-$1});
        return Vector(coords);
    }

    static func *(left: Vector, right: Double) -> Vector {
        let coords = left.coordinates.map({$0 * right});
        return Vector(coords);
    }

    static func *(left: Vector, right: Vector) -> Double {
        return left.dot(right);
    }

    static func ==(lhs: Vector, rhs: Vector) -> Bool {
        return lhs.isEqual(to: rhs);
    }

    func isEqual(to: Vector, precision:Double = DBL_EPSILON) -> Bool {
        if self.coordinates.count != to.coordinates.count {
            return false;
        }

        for (i, l) in self.coordinates.enumerated() {
            if (fabs(l-to.coordinates[i]) > precision) {
                return false;
            }
        }

        return true;
    }

    func isZero() -> Bool {
        for v in self.coordinates {
            if (fabs(0.0-v) > DBL_EPSILON) {
                return false;
            }
        }
        return true;
    }

    func isIdentity() -> Bool {
        for v in self.coordinates {
            if (fabs(1.0-v) > DBL_EPSILON) {
                return false;
            }
        }
        return true;
    }

    func magnitude() -> Double {
        return sqrt(self.coordinates.map({$0*$0}).reduce(0){$0+$1});
    }

    func normalize() -> Vector {
        if (isZero()){
            return self;
        }
        let m = 1.0/self.magnitude();
        return Vector(self.coordinates.map({$0*m}));
    }

    func dot(_ other: Vector) -> Double {
        return zip(self.coordinates, other.coordinates).map({$0*$1}).reduce(0){$0+$1};
    }

    static func theta(_ a: Vector, _ b: Vector) -> Double {
        let rad = acos((a*b)/(a.magnitude()*b.magnitude()));
        return rad;
    }

    static func parallel(_ a: Vector, _ b: Vector) -> Bool {
        if a.isZero() || b.isZero() {
            return true;
        }

        // Parallel vectors will have equal normals or exactly reversed normals
        let an = a.normalize();
        let bn = b.normalize();
        let bnn = bn * -1;

        if (an == bn || an == bnn) {
            return true;
        }

        return false;
    }

    static func orthogonal(_ a: Vector, _ b: Vector, precision: Double = DBL_EPSILON) -> Bool {
        if a.isZero() || b.isZero() {
            return true;
        }

        // Orthogonal vectors, dot product is equal to zero
        return fabs(a*b) < precision;
    }

    // Projection of v onto b
    func projection(onto b: Vector) -> Vector {
        if self.isZero() { return self };
        if b.isZero() { return b };

        // (v • ub) * ub
        let u:Vector = b.normalize();
        let dot:Double = self.dot(u);
        return u * dot;

        // alternative method b * (v • b/|b|^2)
        //let s: Double = self.dot(b)/pow(b.magnitude(),2.0);
        //let v: Vector = b * s;
        //return v;
    }

    // Component of self orthogonal to another vector
    func component(orthogonalTo b: Vector) -> Vector {
        if self.isZero() { return self };
        if b.isZero() { return b };

        // self minus projection of self onto b
        let p: Vector = self.projection(onto: b);
        let c = self - p;
        return c;
    }

}
