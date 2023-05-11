//
//  Colors.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import SwiftUI

extension Color {
    enum Name: String {
        case B_000000_90
        case B_000000_60
        case B_555555_30
        case B_000000_25
        case B_555555_20
        case B_555555
        
        case W_FFFFFF_40
        
    }
}

extension Color.Name {
    var path: String {
        "Colors/\(rawValue)"
    }
}

extension Color {
    init(_ name: Color.Name) {
        self.init(name.path)
    }
    
    static let b_000000_90 = Color(Name.B_000000_90)
    static let b_000000_60 = Color(Name.B_000000_60)
    static let b_555555_30 = Color(Name.B_555555_30)
    static let b_000000_25 = Color(Name.B_000000_25)
    static let b_555555_20 = Color(Name.B_555555_20)
    static let b_555555 = Color(Name.B_555555)
    
    static let w_FFFFFF_40 = Color(Name.W_FFFFFF_40)
}
