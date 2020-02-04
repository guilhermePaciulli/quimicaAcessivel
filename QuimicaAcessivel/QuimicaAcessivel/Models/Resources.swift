//
//  Resources.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 21/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Resources {
    
    static var referenceImages: [ARReferenceImage] = {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing ARReference Images from AR Resources folder.")
        }
        return Array(referenceImages)
    }()
    
    static func getReferenceImage(withName name: String) -> ARReferenceImage? {
        return referenceImages.first(where: { $0.name == name })
    }
}

struct MovementInfo {
    var time: TimeInterval
    var duration: TimeInterval
    var initial: simd_float3
    var final: simd_float3
}
