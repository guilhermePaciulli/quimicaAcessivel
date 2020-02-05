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
    case potassiumChloride
    case hydrochloricAcid
    case potassiumFluoride
    case hydrofluoricAcid
    
    var name: String {
        switch self {
        case .water:
            return "Água"
        case .potassiumChloride:
            return "Cloreto de potássio"
        case .hydrochloricAcid:
            return "Ácido clorídrico"
        case .potassiumFluoride:
            return "Fluoreto de potássio"
        case .hydrofluoricAcid:
            return "Ácido fluorídrico"
        }
    }
    
    var combination: [AtomType] {
        switch self {
        case .water:
            return [.hydrogen, .hydrogen, .oxygen]
        case .potassiumChloride:
            return [.chloride, .potassium]
        case .hydrochloricAcid:
            return [.hydrogen, .chloride]
        case .potassiumFluoride:
            return [.fluoride, .potassium]
        case .hydrofluoricAcid:
            return [.hydrogen, .fluoride]
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    var moleculeDescription: String {
        switch self {
        case .water:
            return "A molécula de água é constituída por dois átomos de hidrogênio ligados a um de oxigênio, com uma estrutura angular. O átomo de oxigênio partilha dois dos seus seis elétrons de valência com os átomos de hidrogênio para formar as ligações covalentes entre oxigênio e hidrogênio."
        case .potassiumChloride:
            return "Cloreto de potássio é um composto inorgânico salino, de fórmula química KCl. É formado por cloreto e o potássio."
        case .hydrochloricAcid:
            return "O ácido clorídrico é formado pelo gás cloreto de hidrogênio (HCl) dissolvido em água, numa proporção de cerca de 37% do gás. É um ácido inorgânico forte, líquido levemente amarelado, em que seus cátions H+ são facilmente ionizáveis na solução."
        case .potassiumFluoride:
            return "O fluoreto de potássio é o composto químico com a fórmula KF. Após o fluoreto de hidrogênio, o KF é a fonte primária do íon fluoreto para aplicações na fabricação e na química. O fluoreto de potássio é preparado dissolvendo o carbonato de potássio em ácido fluorídrico."
        case .hydrofluoricAcid:
            return "O ácido fluorídrico tem como fórmula HF. Ele é composto de um átomo de flúor e um de hidrogênio, conectados por uma ligação covalente. É um líquido incolor, fumegante, com ponto de ebulição de 20 ºC sob pressão normal. Em condições ambientes onde a temperatura é de 25 ºC, ele torna-se um gás."
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
