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

    var dimension: Int {
        get {
            return self.coordinates.count;
        }
    }

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

    static func *(left: Vector, right: Vector) -> Vector {
        return left.cross(right);
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

    // Dot product of self and another vector
    func dot(_ other: Vector) -> Double {
        // a1*b1 + a2*b2 ... aN*bN
        return zip(self.coordinates, other.coordinates).map({$0*$1}).reduce(0){$0+$1};
    }

    // Use the dot product to find theta angle between two vectors
    static func theta(_ a: Vector, _ b: Vector) -> Double {
        // (a • b) / (||a|| * ||b||)
        let rad = acos((a.dot(b))/(a.magnitude()*b.magnitude()));
        return rad;
    }

    // Test if two vectors are parallel
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

    // Test orthogonality of vector a and b
    static func orthogonal(_ a: Vector, _ b: Vector, precision: Double = DBL_EPSILON) -> Bool {
        if a.isZero() || b.isZero() {
            return true;
        }

        // For orthogonal vectors, dot product is equal to zero
        return fabs(a.dot(b)) < precision;
    }

    // Projection of v onto b
    func projection(onto b: Vector) -> Vector {
        if self.isZero() { return self };
        if b.isZero() { return b };

        // ub * (v • ub)
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

    // Cross product yeilds the vector orthoganal to self and b that obeys the right hand rule
    func cross(_ b : Vector) -> Vector {

        // Cross product is primarily relevant for matrix of 3 dimensions
        assert(self.dimension == b.dimension);
        assert(self.dimension == 3);

        if (self.isZero() || b.isZero()) {
            return Vector.zero(length: self.dimension);
        }

        let a: Vector = self;

        // Specific pattern of multiplication based on sarrus rule of finding determinant of a matrix
        let x =   a.y*b.z - b.y*a.z;
        let y = -(a.x*b.z - b.x*a.z);
        let z =   a.x*b.y - b.x*a.y;

        return Vector(x, y, z);
    }

    // Cross product can be used to determine the area of a parallelogram created by two vertices
    static func areaOfParallelogram(_ u: Vector, _ v: Vector) -> Double {
        let c = u.cross(v);
        return c.magnitude();
    }

}
