//
//  Molecule.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 23/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import ARKit

enum Molecule: String, CaseIterable {
    case water
    
    var name: String {
        switch self {
        case .water:
            return "Água"
        }
    }
    
    var combination: [AtomType] {
        switch self {
        case .water:
            return [.hydrogen, .hydrogen, .oxygen]
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    var description: String {
        switch self {
        case .water:
            return "Água (fórmula: H2O) é uma substância química cujas moléculas são formadas por dois átomos de hidrogênio e um de oxigênio. É abundante no Universo, inclusive na Terra, onde cobre grande parte de sua superfície e é o maior constituinte dos fluidos dos seres vivos. As temperaturas do planeta permitem a ocorrência da água em seus três estados físicos principais."
        }
    }
    
    var moleculeDescription: String {
        switch self {
        case .water:
            return "A molécula de água é formada por dois átomos de hidrogênio e um de oxigênio unidos em uma ligação covalente"
        }
    }
    
    
}

extension Molecule {
    
    static func combinationExists(between atoms: [Atom]) -> Molecule? {
        return allCases.first(where: { mol in
            return mol.combination.allSatisfy({ type in
                return mol.combination.first(where: { $0 == type }) != nil
            })
        })
    }
    
}
