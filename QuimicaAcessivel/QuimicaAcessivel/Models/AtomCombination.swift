//
//  AtomCombiner.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 23/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import Foundation

class AtomCombination {

    var atoms: [AtomType]
    
    init(atom1: Atom, atom2: Atom) {
        atoms = [atom1.type, atom2.type]
    }
    
    func checkCombination() -> Molecule? {
        
        let combination = Molecule.allCases.first(where: { mol in
            var values: [AtomType?] = mol.combination
            
            self.atoms.forEach { (a1) in
                values = values.map { (a2) -> AtomType? in
                    if a1 == a2 {
                        return nil
                    }
                    return a2
                }
            }
            
            return values.compactMap({ return $0 }).isEmpty
        })
        
        return combination
    }
    
}
