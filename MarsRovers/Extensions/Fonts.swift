//
//  Fonts.swift
//  MarsRovers
//
//  Created by Steven Kirke on 09.04.2023.
//

import SwiftUI


extension Text {
    func customFont(size: CGFloat) -> some View {
        self
            .font(Font.custom("Helvetica Neue", size: size))
           // .fontDesign(.default)
    }
}
