//
//  MoleculeDetailsViewController.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 27/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit
import SceneKit

class MoleculeDetailsViewController: UIViewController {
    
    var mainViewController: ViewController?
    var molecule: Molecule?
    @IBOutlet weak var moleculeName: UILabel?
    @IBOutlet weak var moleculeDescription: UILabel?
    @IBOutlet weak var moleculeImage: UIImageView?
    @IBOutlet weak var exitButton: UIButton?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let m = molecule else { return }
        
        moleculeName?.text = m.name
        moleculeDescription?.text = m.description
        moleculeImage?.image = m.image
        moleculeImage?.accessibilityLabel = m.moleculeDescription
        moleculeImage?.isAccessibilityElement = true
        exitButton?.accessibilityLabel = "Sair"
    }
    
    @IBAction func didTapToExit(_ sender: Any) {
        dismiss(animated: true) {
            self.mainViewController?.resetTracking()
        }
    }
}
