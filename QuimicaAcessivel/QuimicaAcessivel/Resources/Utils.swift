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

extension simd_float4x4 {
    
    var vector3: SCNVector3 {
        return SCNVector3(columns.3.x, columns.3.y, columns.3.z)
    }
    
    var simd_vector3: simd_float3 {
        return simd_float3(columns.3.x, columns.3.y, columns.3.z)
    }
    
}

extension SCNVector3 {
    
    static func /(lhs: inout SCNVector3, rhs: Float) {
        lhs.x /= rhs
        lhs.y /= rhs
        lhs.z /= rhs
    }
    
}

protocol Identifiable: class {}

extension UIViewController: Identifiable {}

extension Identifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    static var xibIdentifier: String {
        return String(describing: self)
    }
}


extension UIViewController {
    
    static func instantiate<T: UIViewController>() -> T {
        guard let controller = UIStoryboard(name: (T.storyboardIdentifier.replacingOccurrences(of: "Controller", with: "")).replacingOccurrences(of: "View", with: ""), bundle: T.bundle).instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("failed to create storyBoard/xib")}
        return controller
    }
    
    static var bundle: Bundle {
        return Bundle(for: self)
    }
}

extension String {
    
    var audioForName: SCNAudioPlayer? {
        guard let audioSource = SCNAudioSource(fileNamed: "\(self).wav") else { return nil }
        audioSource.load()
        return SCNAudioPlayer(source: audioSource)
    }
    
}

extension SCNAudioPlayer {
    func withLoop(_ value: Bool) -> SCNAudioPlayer {
        self.audioSource?.loops = true
        return self
    }
}
