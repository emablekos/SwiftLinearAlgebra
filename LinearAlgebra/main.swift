//
//  main.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/26/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation

var l1 = Plane(A:-0.412, B:3.806, C:0.728, k:-3.46);
var l2 = Plane(A: 1.03, B: -9.515, C: -1.82, k: 8.65)
print(Plane.parallel(a: l1, b: l2));
print(l1.isEqual(to: l2, precision: 0.001));
print("---")

l1 = Plane(A: 2.611, B: 5.528, C: 0.283, k: 4.6)
l2 = Plane(A: 7.715, B: 8.306, C: 5.342, k: 3.76)
print(Plane.parallel(a: l1, b: l2));
print(l1.isEqual(to: l2, precision: 0.001));
print("---")

l1 = Plane(A: -7.926, B: 8.625, C: -7.212, k: -7.952)
l2 = Plane(A: -2.642, B: 2.875, C: -2.404, k: -2.443)
print(Plane.parallel(a: l1, b: l2));
print(l1.isEqual(to: l2, precision: 0.001));
print("---")

