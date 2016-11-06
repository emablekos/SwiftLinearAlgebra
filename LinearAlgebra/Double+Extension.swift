//
//  Double+Extension.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 11/1/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation

infix operator ~==

extension Double {

    static func ~==(lhs: Double, rhs: Double) -> Bool {
        return lhs.isEqual(to: rhs);
    }

    func isEqual(to: Double, precision: Double = 0.0000000000001) -> Bool {
        return abs(to - self) < precision;
    }

    func isNearZero() -> Bool {
        return self.isEqual(to: 0.0, precision: 0.0000000000001);
    }
}
