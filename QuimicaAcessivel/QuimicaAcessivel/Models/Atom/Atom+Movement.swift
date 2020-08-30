//
//  Atom+Movement.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 23/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import SceneKit
import ARKit

extension Atom {
    
    func initializeAtom(inScene scene: SCNScene, withAnchor anchor: ARImageAnchor) {
        guard let object = type.atomObject() else { return }
        
        let (min, max) = object.boundingBox
        let size = SCNVector3Make(max.x - min.x, max.y - min.y, max.z - min.z)
        
        let widthRatio = Float(anchor.referenceImage.physicalSize.width) / size.x
        let heightRatio = Float(anchor.referenceImage.physicalSize.height) / size.z
        object.transform = SCNMatrix4(anchor.transform)
        
        guard let finalRatio = [widthRatio, heightRatio].min() else { return }
        
        let appearanceAction = SCNAction.scale(to: CGFloat(finalRatio / 2), duration: 1)
        appearanceAction.timingMode = .easeOut
        object.scale = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(object)
        object.runAction(appearanceAction) {
            scene.rootNode.removeAllAudioPlayers()
        }
        
        
        atomAnchor = anchor
        atomScene = scene
        atomObject = object
    }
    
    func didUpdateTo(anchor: ARImageAnchor) {
        guard anchor == atomAnchor else { return }
        atomAnchor = anchor
        if isMoving() { atomObject?.removeAction(forKey: "movement") }
        moveTo(newAnchor: anchor)
    }
    
    private func moveTo(newAnchor: ARAnchor) {
        let action = SCNAction.move(to: newAnchor.transform.vector3, duration: 0.6)
        action.timingMode = .easeIn
        runningMovementAction = action
        atomObject?.runAction(action, forKey: "movement")
    }
    
}
