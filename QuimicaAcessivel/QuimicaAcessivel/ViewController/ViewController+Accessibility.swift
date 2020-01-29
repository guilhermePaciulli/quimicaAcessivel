//
//  ViewController+Accessibility.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Horcaio Paciulli on 28/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import UIKit

extension ViewController: AccessibilityManagerDelegate {
    
    func didChangeQueueState(queue: [String]) {
        guard let molecule = moleculeFound, queue.isEmpty else { return }
        goToDetails(molecule)
        moleculeFound = nil
    }
    
}
