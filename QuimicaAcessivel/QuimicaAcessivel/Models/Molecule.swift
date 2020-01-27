//
//  Molecule.swift
//  QuimicaAcessivel
//
//  Created by Guilherme Paciulli on 23/01/20.
//  Copyright © 2020 Guilherme Paciulli. All rights reserved.
//

import ARKit

enum Molecule: String, CaseIterable {
    case testing
    
    var name: String {
        switch self {
        case .testing:
            return "Hidróxido de carbono"
        }
    }
    
    var combination: [AtomType] {
        switch self {
        case .testing:
            return [.hydrogen, .sodium]
        }
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    var description: String {
        switch self {
        case .testing:
            return "Svetlana Alekseyevna Smirnova (née Veresova) (Russian: Светлана Алексеевна Смирнова; born March 10, 1962 in Pskov) is a Russian sport shooter.[2] She won two medals (silver and bronze), as a member of the Soviet Union shooting team, at the 1987 ISSF World Shooting Championships in Budapest, Hungary, and at the 1990 ISSF World Shooting Championships in Moscow, Russia."
        }
    }
    
    
}
