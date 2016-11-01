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

    func isEqual(to: Double, precision: Double = DBL_EPSILON) -> Bool {
        return abs(to - self) < DBL_EPSILON;
    }
}
