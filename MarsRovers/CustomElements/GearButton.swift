//
//  GearButton.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.06.2023.
//

import SwiftUI

struct GearButton: View {
    
    @Binding var isSetting: Bool
    
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                withAnimation {
                    self.isSetting.toggle()
                }
            }
        }) {
            Image.gear
                .iconSize(size: 30)
                .rotationEffect(Angle(degrees: isSetting ? -90 : 0))
        }
    }
}

#if DEBUG
struct GearButton_Previews: PreviewProvider {
    static var previews: some View {
        GearButton(isSetting: .constant(true), action: {})
    }
}
#endif

