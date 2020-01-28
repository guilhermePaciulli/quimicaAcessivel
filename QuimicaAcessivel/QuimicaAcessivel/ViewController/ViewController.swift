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
import Speech

class ViewController: UIViewController, ARSCNViewDelegate {
    
    // MARK:- IBOutlets
    @IBOutlet var sceneView: ARSCNView?
    
    // MARK:- Properties
    var atoms: [Atom] = AtomType.displayableAtoms()
    var visibleAtoms: [Atom] = []
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestForSpeechRecognition()
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
        sceneView?.scene.physicsWorld.gravity = SCNVector3(0, 0, 0)
    }
    
    private func resetTracking() {
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = Set(Resources.referenceImages)
        session?.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    private func requestForSpeechRecognition() {
        SFSpeechRecognizer.requestAuthorization { _ in }
    }
    
    
}

