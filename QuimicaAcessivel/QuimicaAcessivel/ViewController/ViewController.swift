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
    var atoms: [Atom] = AtomType.displayableAtoms()
    var visibleAtoms: [Atom] = []
    var session: ARSession? { return sceneView?.session }
    var moleculeFound: Molecule?
    var timer: Timer?
    
    // MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSceneView()
        AccessibilityManager.shared.subscribe(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTracking()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lookingForAtomsAlert()
    }
    
    func goToDetails(_ molecule: Molecule) {
        let details: MoleculeDetailsViewController = MoleculeDetailsViewController.instantiate()
        details.molecule = molecule
        details.modalPresentationStyle = .overCurrentContext
        details.modalTransitionStyle = .crossDissolve
        details.mainViewController = self
        present(details, animated: true) {
            self.timer?.invalidate()
        }
    }
    
    func resetTracking() {
        atoms = AtomType.displayableAtoms()
        atoms.forEach({ $0.flag = false })
        visibleAtoms = []
        moleculeFound = nil
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = Set(Resources.referenceImages)
        session?.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // MARK:- Private methods
    private func setupSceneView() {
        let scene = SCNScene()
        sceneView?.scene = scene
        sceneView?.delegate = self
        sceneView?.scene.physicsWorld.gravity = SCNVector3(0, 0, 0)
    }
    
    
}

