//
//  Utils.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 22/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

extension SCNVector3 {
    func length() -> Float {
        return sqrtf(x * x + y * y + z * z)
    }
}

extension simd_float3 {
    func length() -> Float {
        return sqrtf(x * x + y * y + z * z)
    }
}

func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(l.x - r.x, l.y - r.y, l.z - r.z)
}

extension SCNVector3 {
    static func distanceFrom(vector vector1: SCNVector3, toVector vector2: SCNVector3) -> Float {
        let x0 = vector1.x
        let x1 = vector2.x
        let y0 = vector1.y
        let y1 = vector2.y
        let z0 = vector1.z
        let z1 = vector2.z
        
        return sqrtf(powf(x1-x0, 2) + powf(y1-y0, 2) + powf(z1-z0, 2))
    }
}

extension vector_float3 {

    /// Returns the angle of a line defined by to points to a horizontal plane
    ///
    /// - Parameters:
    ///   - p1: p1 (vertice)
    ///   - p2: p2
    /// - Returns: angle to a horizontal crossing p1 in radians
    static func angleBetweenPointsToHorizontalPlane(p1: vector_float3, p2: vector_float3) -> Float {

        ///Point in 3d space on the same level of p1 but equal to p2
        let p2Hor = vector_float3(p2.x, p1.y, p2.z)

        let p1ToP2Norm = normalize(p2 - p1)
        let p1ToP2HorNorm = normalize(p2Hor - p1)

        let dotProduct = dot(p1ToP2Norm, p1ToP2HorNorm)

        let angle = acos(dotProduct)

        return angle
    }
}
