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
    
    var molecule: Molecule?
    @IBOutlet weak var moleculeName: UILabel?
    @IBOutlet weak var moleculeDescription: UILabel?
    @IBOutlet weak var moleculeImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let m = molecule else { return }
        
        moleculeName?.text = m.name
        moleculeDescription?.text = m.description
        moleculeImage?.image = m.image
    }
    
    @objc func didTapScreen() {
        dismiss(animated: true)
    }
    

}
