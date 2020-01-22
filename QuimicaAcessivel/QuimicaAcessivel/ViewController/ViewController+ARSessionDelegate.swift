//
//  ViewController+ARSessionDelegate.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 16/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import RealityKit

extension ViewController: ARSessionDelegate {
    
    // MARK:- Delegate methods
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let imageAnchor = anchor as? ARImageAnchor, let scene = SCNScene(named: "art.scnassets/atom.scn"), let atomNode = scene.rootNode.childNode(withName: "atom", recursively: true) else {
            print("anchor not found")
            return
        }

        let (min, max) = atomNode.boundingBox
        let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)

        let widthRatio = Float(imageAnchor.referenceImage.physicalSize.width) / size.x
        let heightRatio = Float(imageAnchor.referenceImage.physicalSize.height) / size.z
        atomNode.transform = SCNMatrix4(imageAnchor.transform)

        guard let finalRatio = [widthRatio, heightRatio].min() else { return }

        let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio / 2), duration: 0.4)
        appearanceAction.timingMode = .easeOut
        atomNode.scale = SCNVector3Make(0, 0, 0)
        sceneView?.scene.rootNode.addChildNode(atomNode)
        atomNode.runAction(appearanceAction)

        anchoredNode = atomNode
        imageNode = node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let imageNode = imageNode, let atomNode = anchoredNode else { return }
        
        guard let animationInfo = animationInfo else {
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
        animationInfo = AnimationInfo(time: time, duration: animationDuration, initial: from, final: to)
    }
    
}
