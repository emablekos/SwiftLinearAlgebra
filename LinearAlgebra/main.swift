//
//  main.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/26/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation

var l1 = Line(A:4.046, B:2.836, k:1.21);
var l2 = Line(A:10.115, B:7.09, k:3.025);
print(Line.parallel(a: l1, b: l2));
print(l1.isEqual(to: l2));
print(Line.intersection(a: l1, b: l2));
print("---")

l1 = Line(A:7.204, B:3.182, k:8.68);
l2 = Line(A:8.172, B:4.114, k:9.883);
print(Line.parallel(a: l1, b: l2));
print(l1.isEqual(to: l2));
print(Line.intersection(a: l1, b: l2));
print("---")

l1 = Line(A:1.182, B:5.562, k:6.744);
l2 = Line(A:1.773, B:8.343, k:9.525);
print(Line.parallel(a: l1, b: l2));
print(l1.isEqual(to: l2));
print(Line.intersection(a: l1, b: l2));
print("---")

