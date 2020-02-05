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
        moleculeName?.isAccessibilityElement = false
        moleculeDescription?.text = m.moleculeDescription
        moleculeDescription?.isAccessibilityElement = false
        moleculeImage?.image = m.image
        moleculeImage?.isAccessibilityElement = false
        exitButton?.accessibilityLabel = textDescription
    }
    
    @IBAction func didTapToExit(_ sender: Any) {
        dismiss(animated: true) {
            self.mainViewController?.resetTracking()
        }
    }
    
    var textDescription: String {
        guard let m = molecule else { return "" }
        return "Informações sobre \(m.name). Toque duas vezes para sair. \(m.moleculeDescription)"
    }
}
