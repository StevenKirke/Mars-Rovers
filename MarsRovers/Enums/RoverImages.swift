//
//  RoverImages.swift
//  MarsRovers
//
//  Created by Steven Kirke on 13.04.2023.
//

import SwiftUI


enum RoverImages: CaseIterable {
    case opportunity
    case curiosity
    case perseverance
    case spirit
    
    var title: String {
        switch self {
            case .opportunity:
                return "opportunity"
            case .curiosity:
                return "curiosity"
            case .perseverance:
                return "perseverance"
            case .spirit:
                return "spirit"
        }
    }
    
    var bigImage: Image {
        switch self {
            case .opportunity:
                return Image.opportunity
            case .curiosity:
                return  Image.curiosity
            case .perseverance:
                return Image.perseverance
            case .spirit:
                return  Image.spirit
        }
    }
    var littleImage: Image {
        switch self {
            case .opportunity:
                return  Image.iconOpportunity
            case .curiosity:
                return Image.iconCuriosity
            case .perseverance:
                return Image.iconPerseverance
            case .spirit:
                return  Image.iconSpirit
        }
    }
}
