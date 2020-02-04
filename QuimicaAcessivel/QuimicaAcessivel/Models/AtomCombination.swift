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
        guard Molecule.combinationExists(between: [atom1, atom2]) != nil else { return nil }
        atoms = [atom1, atom2]
    }
    
    func getMoleculeIfExists() -> Molecule? {
        return Molecule.allCases.first(where: { mol in
            let values = mol.combination.sorted(by: { $0.name > $1.name })
            let atoms = self.atoms.map({ $0.type }).sorted(by: { $0.name > $1.name })
            return values == atoms
        })
    }
    
    func isCombining() -> Bool {
        return !atoms.isEmpty
    }
    
    func appendIfPossible(_ atom: Atom) -> AtomCombination? {
        guard let possible = Molecule.combinationExists(between: atoms + [atom]) else { return nil }
        if possible.combination.histogram[atom.type] ?? -1 > atoms.filter({ $0.type == atom.type }).count {
            atoms.append(atom)
        }
        return self
    }
    
}

extension Array where Element: Hashable {
    var histogram: [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
}
