//
//  ViewController.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 16/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK:- IBOutlets
    @IBOutlet var sceneView: ARSCNView?
    
    // MARK:- Properties
    var animationInfo: AnimationInfo?
    var anchoredNode: SCNNode?
    var imageNode: SCNNode?
    var session: ARSession? { return sceneView?.session }
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTracking()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session?.pause()
    }
    
    // MARK:- Private methods
    private func setupSceneView() {
        let scene = SCNScene()
        sceneView?.scene = scene
        sceneView?.delegate = self
    }
    
    private func resetTracking() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { fatalError("Missing expected resources.") }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        session?.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}

struct AnimationInfo {
    var time: TimeInterval
    var duration: TimeInterval
    var initial: simd_float3
    var final: simd_float3
}

