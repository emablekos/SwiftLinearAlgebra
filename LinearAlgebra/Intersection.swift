//
//  Intersection.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 11/2/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation



struct Intersection {

    enum Kind {
        case none, vector, line, plane, parameters
    }

    let kind: Kind;
    let value: Any;

    init() {
        self.kind = Intersection.Kind.none;
        self.value = 0;
    }

    init(_ vector: Vector) {
        self.kind = Intersection.Kind.vector
        self.value = vector;
    }

    init(_ line: Line) {
        self.kind = Intersection.Kind.line;
        self.value = line;
    }

    init(_ plane: Plane) {
        self.kind = Intersection.Kind.plane;
        self.value = plane;
    }

    init(_ vectors: [Vector]) {
        self.value = vectors;
        self.kind = Kind.parameters;
    }
}
