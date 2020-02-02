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
    }
    
    func lookingForAtomsAlert() {
        timer = .scheduledTimer(withTimeInterval: 15, repeats: true, block: { (timer) in
            say("Procurando por átomos")
        })
    }
    
    func focusedAtomsAlert() {
        timer = .scheduledTimer(withTimeInterval: 15, repeats: true, block: { (timer) in
            guard !self.visibleAtoms.isEmpty else {
                timer.invalidate()
                self.lookingForAtomsAlert()
                return
            }
            say("Átomos em foco: \(self.visibleAtoms.reduce("", { "\($0), \($1.type.name)" }))")
        })
    }
    
}
