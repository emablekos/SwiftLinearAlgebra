//
//  LinearSystem.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 11/2/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation



struct LinearSystem : CustomStringConvertible, CustomDebugStringConvertible {

    enum TriangularFormResult {
        case none, consistent, inconsistent, rref;
    }

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

    subscript(safe i: Int) -> Plane? {
        get {
            return i >= 0 && i < objects.count ? objects[i] : nil;
        }
    }

    static func firstNonZeroIndices(objects: [Plane]) -> [Int] {
        return objects.map{p in Plane.firstNonZeroIndex(p.normal.coordinates)};
    }

    mutating func swapRows(_ i: Int, _ j: Int) {
        let pi = self.objects[i];
        let pj = self.objects[j];

        self.objects.replaceSubrange(i..<i+1, with: [pj]);
        self.objects.replaceSubrange(j..<j+1, with: [pi]);
    }

    mutating func multiplyRow(_ i: Int, by: Double) {
        var pi = self.objects[i];
        pi = Plane(normal: pi.normal*by, constant: pi.constant*by)

        self.objects.replaceSubrange(i..<i+1, with: [pi]);
    }

    mutating func addRow(_ i: Int, to j: Int, multiplier by: Double) {
        var pi = self.objects[i];
        var pj = self.objects[j];

        pi = Plane(normal: pi.normal*by, constant: pi.constant*by);
        pj = Plane(normal: pj.normal + pi.normal, constant: pj.constant + pi.constant);

        self.objects.replaceSubrange(j..<j+1, with: [pj]);
    }

    mutating func computeTriangularForm() -> TriangularFormResult {

        let rowCount = self.objects.count;
        var column = 0;
        var isTriangular = false;

        while column < dimension && column < rowCount && !isTriangular {

            // Check for inconsistent result
            for (_, p) in self.objects.enumerated() {
                if (p.normal.isZero()) && !p.constant.isNearZero() {
                    return TriangularFormResult.inconsistent;
                }
            }

            var allLeading = true;
            for (i, p) in self.objects.enumerated() {

                for j in 0..<i {
                    if !p.normal[j].isNearZero() {
                        allLeading = false
                        break;
                    }
                }
            }
            if (allLeading) {
                isTriangular = true;
                continue;
            }

            let row = column;
            var swapRow = row+1;

            while self.objects[row].normal[column].isEqual(to: 0.0) {
                if swapRow >= rowCount {
                    column += 1
                    swapRow = row + 1

                    if (column >= dimension) {
                        assert(false)
                    }
                }

                self.swapRows(row, swapRow);
                swapRow += 1;
            }

            var targetRow = row+1;
            while targetRow < rowCount {
                if (objects[targetRow].normal[column].isEqual(to: 0.0)) {
                    targetRow += 1;
                    continue;
                }

                let mult = objects[targetRow].normal[column] / objects[row].normal[column];
                addRow(row, to: targetRow, multiplier: -mult);

                targetRow += 1;
            }

            column += 1;
        }

        return TriangularFormResult.consistent;
    }

    mutating func computeRREF() -> Intersection {

        let result = self.computeTriangularForm();

        if result != TriangularFormResult.consistent {
            return Intersection();
        }

        for row in (0..<self.objects.count).reversed() {

            let p = self[row];
            let col = p.normal.firstNonZeroCoordinate();

            if let c = p.normal[safe: col] {
                self.multiplyRow(row, by: 1.0/c);
            }
        }

        for row in (1..<self.objects.count).reversed() {

            let p2 = self[row];

            let col = p2.normal.firstNonZeroCoordinate();

            if let _ = p2.normal[safe: col] {

                for target in (0..<row).reversed() {
                    let p1 = self[target];
                    if let c:Double = p1.normal[safe: col], !c.isNearZero() {
                        self.addRow(row, to: target, multiplier: -c);
                    }
                }
            }
        }

        var solution: [Double] = Array.init(repeating: 0.0, count: self.dimension);

        var parameters: [[Double]] = [];
        for i in 0..<self.dimension {
            var p = Array.init(repeating: 0.0, count: self.dimension);
            p[i] = 1.0;
            parameters.append(p);
        }

        for (_,p) in self.objects.enumerated() {
            let col = p.normal.firstNonZeroCoordinate();
            if col != NSNotFound {
                solution[col] = p.constant;
                parameters[col] = [];

                for ncol in col+1..<self.dimension {
                    if !p.normal[ncol].isNearZero() {
                        parameters[ncol][col] = -p.normal[ncol];
                    }
                }
            }
        }
        parameters = parameters.filter{$0.count > 0}

        if parameters.count > 0 {
            var vectors: [Vector] = [Vector(solution)];
            vectors.append(contentsOf: parameters.map{Vector($0)});

            return Intersection(vectors);
        }

        return Intersection(Vector(solution));
    }

    var description: String {
        return objects.map{$0.description}.joined(separator: "\n");
    }
    
    var debugDescription: String {
        return objects.map{$0.description}.joined(separator: "\n");
    }
}
