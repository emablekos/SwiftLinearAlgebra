//
//  LinearSystem.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 11/2/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation


class LinearSystem : CustomStringConvertible {

    var objects: [Plane];
    let dimension: Int;

    init(_ objects: [Plane]) {
        self.objects = objects;

        self.dimension = objects.first!.dimension;
        for (_,p) in objects.enumerated() {
            assert(p.dimension == self.dimension)
        }
    }

    subscript(i: Int) -> Plane {
        get {
            return objects[i];
        }
    }

    static func firstNonZeroIndices(objects: [Plane]) -> [Int] {
        return objects.map{Plane.firstNonZeroIndex($0.normal.coordinates)};
    }

    func swapRows(_ i: Int, _ j: Int) {
        let pi = self.objects[i];
        let pj = self.objects[j];

        self.objects.replaceSubrange(i..<i+1, with: [pj]);
        self.objects.replaceSubrange(j..<j+1, with: [pi]);
    }

    func multiplyRow(_ i: Int, by: Double) {
        var pi = self.objects[i];
        pi = Plane(normal: pi.normal*by, constant: pi.constant*by)

        self.objects.replaceSubrange(i..<i+1, with: [pi]);
    }

    func addRow(_ i: Int, to j: Int, multiplier by: Double) {
        var pi = self.objects[i];
        var pj = self.objects[j];

        pi = Plane(normal: pi.normal*by, constant: pi.constant*by);
        pj = Plane(normal: pj.normal + pi.normal, constant: pj.constant + pi.constant);

        self.objects.replaceSubrange(j..<j+1, with: [pj]);
    }

    var description: String {
        return objects.map{$0.description}.joined(separator: "\n");
    }






}
