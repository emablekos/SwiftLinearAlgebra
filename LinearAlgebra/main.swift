//
//  main.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/26/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation

var a,b,c: Vector;
a = Vector(3.039,1.879);
b = Vector(0.825,2.036);
print(a.projection(onto: b));

a = Vector(-9.88,-3.264,-8.159);
b = Vector(-2.155,-9.353,-9.473);
print(a.component(orthogonalTo: b));

a = Vector([3.009, -6.172, 3.692, -2.51]);
b = Vector([6.404, -9.144, 2.759, 8.718]);
print(a.projection(onto: b));
print(a.component(orthogonalTo: b));




