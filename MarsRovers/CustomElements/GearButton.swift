//
//  GearButton.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.06.2023.
//

import SwiftUI

struct GearButton: View {
    
    var rotate: Double
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image.gear
                .iconSize(size: 30)
                .rotationEffect(Angle(degrees: rotate))
        }
    }
}

#if DEBUG
struct GearButton_Previews: PreviewProvider {
    static var previews: some View {
        GearButton(rotate: 0, action: {})
    }
}
#endif

