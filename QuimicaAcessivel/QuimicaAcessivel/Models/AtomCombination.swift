//
//  AtomCombiner.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 23/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

class AtomCombination {

    var atoms: [Atom]
    
    init?(atom1: Atom, atom2: Atom) {
        guard Molecule.combinationExists(between: [atom1, atom2]) else { return nil }
        atoms = [atom1, atom2]
    }
    
    func getMoleculeIfExists() -> Molecule? {
        
        let combination = Molecule.allCases.first(where: { mol in
            var values: [AtomType?] = mol.combination
            
            self.atoms.forEach { (a1) in
                values = values.map { (a2) -> AtomType? in
                    if a1.type == a2 {
                        return nil
                    }
                    return a2
                }
            }
            
            return values.compactMap({ return $0 }).isEmpty
        })
        
        return combination
    }
    
    func isCombining() -> Bool {
        return !atoms.isEmpty
    }
    
    func appendIfPossible(_ atom: Atom) -> AtomCombination? {
        guard Molecule.combinationExists(between: atoms + [atom]) else { return nil }
        return self
    }
    
    
}
