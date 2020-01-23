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
    
    static var atomNode: SCNNode = {
        guard let scene = SCNScene(named: "art.scnassets/atom.scn") else { fatalError("Missing atom.scn file!") }
        guard let atomNode = scene.rootNode.childNode(withName: "atom", recursively: true) else { fatalError("Missing atom node in atom.scn file!") }
        return atomNode
    }()
    
    static var referenceImages: [ARReferenceImage] = {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing ARReference Images from AR Resources folder.")
        }
        return Array(referenceImages)
    }()
    
}

struct MovementInfo {
    var time: TimeInterval
    var duration: TimeInterval
    var initial: simd_float3
    var final: simd_float3
}
