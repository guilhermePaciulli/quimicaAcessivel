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
        guard let object = type.atomObject(), let sound = type.sound() else { return }
        
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
        scene.rootNode.addAudioPlayer(sound)
        object.runAction(appearanceAction) {
            scene.rootNode.removeAllAudioPlayers()
        }
        
        
        atomAnchor = anchor
        atomScene = scene
        atomObject = object
    }
    
    func didUpdateTo(anchor: ARImageAnchor) {
        guard anchor == atomAnchor else { return }
        let d = length(anchor.transform.simd_vector3 - atomAnchor!.transform.simd_vector3)
        atomAnchor = anchor
        if isMoving() { atomObject?.removeAction(forKey: "movement") }
        moveTo(newAnchor: anchor, distance: d)
    }
    
    private func moveTo(newAnchor: ARAnchor, distance: Float) {
        guard let sound = type.sound()?.withLoop(true) else { return }
        if  distance > 2 { atomScene?.rootNode.addAudioPlayer(sound) }
        let action = SCNAction.move(to: newAnchor.transform.vector3, duration: TimeInterval(distance / 30.0))
        action.timingMode = .easeIn
        runningMovementAction = action
        atomObject?.runAction(action, forKey: "movement") {
            self.atomScene?.rootNode.removeAllAudioPlayers()
        }
    }
    
}
