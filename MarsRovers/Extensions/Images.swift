//
//  Images.swift
//  MarsRovers
//
//  Created by Steven Kirke on 10.04.2023.
//

import SwiftUI



extension Image {
    
    enum Rovers: String {
        case Curiosity
        case Perseverance
        case SpiritAndOpportunity
    }
    
    enum Icons: String {
        case camera
        case earth
        case gear
        case parachute
        case pictures
        case rocked
        case sun
    }
    
    
    enum LittleIcon: String {
        case IconCuriosity
        case IconPerseverance
        case IconSpirit
    }
    
    enum Logo: String {
        case NASAMiddleLogo
    }
    
    enum Outher: String {
        case starfield
    }
    

    init(_ name: Image.Rovers) {
        self.init(name.path)
    }
    
    init(_ name: Image.Icons) {
        self.init(name.path)
    }
    
    init(_ name: Image.LittleIcon) {
        self.init(name.path)
    }
    
    init(_ name: Image.Logo) {
        self.init(name.path)
    }
    
    init(_ name: Image.Outher) {
        self.init(name.path)
    }
    
    static let curiosity = Image(Rovers.Curiosity)
    static let perseverance = Image(Rovers.Perseverance)
    static let spirit = Image(Rovers.SpiritAndOpportunity)
    static let opportunity = Image(Rovers.SpiritAndOpportunity)
    
    static let camera = Image(Icons.camera)
    static let earth = Image(Icons.earth)
    static let gear = Image(Icons.gear)
    static let parachute = Image(Icons.parachute)
    static let pictures = Image(Icons.pictures)
    static let rocked = Image(Icons.rocked)
    static let sun = Image(Icons.sun)
    
    static let iconCuriosity = Image(LittleIcon.IconCuriosity)
    static let iconPerseverance = Image(LittleIcon.IconPerseverance)
    static let iconSpirit = Image(LittleIcon.IconSpirit)
    static let iconOpportunity = Image(LittleIcon.IconSpirit)
    
    static let logo = Image(Logo.NASAMiddleLogo)
    
    static let starfield = Image(Outher.starfield)
}

extension Image.Rovers {
    var path: String {
        "Images/ImageRovers/\(rawValue)"
    }
}

extension Image.Icons {
    var path: String {
        "Images/Icons/\(rawValue)"
    }
}

extension Image.LittleIcon {
    var path: String {
        "Images/LittleIcons/\(rawValue)"
    }
}

extension Image.Logo {
    var path: String {
        "Images/\(rawValue)"
    }
}

extension Image.Outher {
    var path: String {
        "Images/OutherImage/\(rawValue)"
    }
}

extension Image {
    func iconSize(size: CGFloat) -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size, height: size)
            .foregroundColor(Color.white)
    }
}
