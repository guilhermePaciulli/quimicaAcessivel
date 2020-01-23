//
//  Atom.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 21/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Atom {
    
    var type: AtomType
    var referenceImage: ARReferenceImage
    var imageNode: SCNNode?
    var atomAnchor: ARImageAnchor?
    var atomObject: SCNNode?
    var atomScene: SCNScene?
    var movement: MovementInfo?
    
    init?(with type: AtomType) {
        self.type = type
        guard let image = Resources.referenceImages.first(where: { $0.name == type.rawValue }) else {
            return nil
        }
        referenceImage = image
    }
    
    func initializeAtom(inScene scene: SCNScene, withAnchor anchor: ARImageAnchor, andImageNode image: SCNNode) {
        guard let object = type.atomObject() else { return }
        
        let (min, max) = object.boundingBox
        let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)
        
        let widthRatio = Float(anchor.referenceImage.physicalSize.width) / size.x
        let heightRatio = Float(anchor.referenceImage.physicalSize.height) / size.z
        object.transform = SCNMatrix4(anchor.transform)
        
        guard let finalRatio = [widthRatio, heightRatio].min() else { return }
        
        let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio / 2), duration: 0.4)
        appearanceAction.timingMode = .easeOut
        object.scale = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(object)
        object.runAction(appearanceAction)
        
        
        imageNode = image
        atomAnchor = anchor
        atomScene = scene
        atomObject = object
    }
    
    
    func updatePosition(atTime time: TimeInterval) {
        guard let imageNode = imageNode, let atomNode = atomObject else { return }
        
        guard let animationInfo = movement else {
            refreshAt(time: time, from: atomNode.simdWorldPosition, to: imageNode.simdWorldPosition)
            return
        }
        
        if !simd_equal(animationInfo.final, imageNode.simdWorldPosition) {
            refreshAt(time: time, from: atomNode.simdWorldPosition, to: imageNode.simdWorldPosition)
        }
        
        let passedTime = time - animationInfo.time
        var t = min(Float(passedTime / animationInfo.duration), 1)
        t = sin(t * .pi * 0.5)
        
        let f3t = simd_make_float3(t, t, t)
        atomNode.simdWorldPosition = simd_mix(animationInfo.initial, animationInfo.final, f3t)
    }
    
    private func refreshAt(time: TimeInterval, from: SIMD3<Float>, to: SIMD3<Float>) {
        let distance = simd_distance(from, to)
        let speed = Float(0.15)
        let animationDuration = Double(min(max(0.1, distance / speed), 2))
        movement = MovementInfo(time: time, duration: animationDuration, initial: from, final: to)
    }
    
    
}
