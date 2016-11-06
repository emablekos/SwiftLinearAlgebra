//
//  main.swift
//  LinearAlgebra
//
//  Created by E.J. Mablekos on 10/26/16.
//  Copyright © 2016 EJ Mablekos. All rights reserved.
//

import Foundation
var s: LinearSystem;
var i: Intersection;

s = LinearSystem([
    Plane(A: 5.862, B: 1.178, C: -10.366, k: -8.15),
    Plane(A:-2.931, B:-0.589, C: 5.183, k:-4.075)
    ]);
//i = s.computeRREF();
//print(i);

s = LinearSystem([
    Plane(A: 8.631, B: 5.112, C: -1.816, k: -5.113),
    Plane(A: 4.315, B:11.132, C:-5.27, k:-6.775),
    Plane(A:-2.158, B: 3.01, C:-1.727, k:-0.831)
    ]);
//i = s.computeRREF();
//print(i);

s = LinearSystem([
    Plane(A: 5.262, B: 2.739, C: -9.878, k: -3.441),
    Plane(A: 5.111, B: 6.358, C: 7.638, k: -2.152),
    Plane(A: 2.016, B: -9.924, C: -1.367, k: -9.278),
    Plane(A: 2.167, B:-13.543, C:-18.883, k:-10.567)
    ]);
i = s.computeRREF();
print(i);
