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

extension UIColor {

    func to(color: UIColor, percentage: CGFloat) -> UIColor {
        let from = cgColor.components!
        let toColor = color.cgColor.components!

        let color = UIColor(red: from[0] + (toColor[0] - from[0]) * percentage, green: from[1] + (toColor[1] - from[1]) * percentage,
                            blue: from[2] + (toColor[2] - from[2]) * percentage, alpha: from[3] + (toColor[3] - from[3]) * percentage)
        return color
    }
}


extension SCNAction {
    
    open class func animateColor(from color: UIColor, to toColor: UIColor, withDuration duration: TimeInterval) -> SCNAction {
        return SCNAction.customAction(duration: duration, action: { (node, elapsedTime) in
            let percentage = elapsedTime / CGFloat(duration)
            node.geometry?.firstMaterial?.diffuse.contents = toColor.to(color: color, percentage: percentage)
        })
    }
    
}

extension simd_float4x4 {
    
    var vector3: SCNVector3 {
        return SCNVector3(columns.3.x, columns.3.y, columns.3.z)
    }
    
    var simd_vector3: simd_float3 {
        return simd_float3(columns.3.x, columns.3.y, columns.3.z)
    }
    
}

extension SCNVector3 {
    func distanceTo(_ vector: SCNVector3) -> Float {
        let x0 = x
        let x1 = vector.x
        let y0 = y
        let y1 = vector.y
        let z0 = z
        let z1 = vector.z
        
        return sqrtf(powf(x1 - x0, 2) + powf(y1 - y0, 2) + powf(z1 - z0, 2))
    }
}
