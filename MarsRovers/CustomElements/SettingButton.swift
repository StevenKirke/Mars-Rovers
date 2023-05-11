//
//  SettingButton.swift
//  MarsRovers
//
//  Created by Steven Kirke on 13.04.2023.
//

import SwiftUI

struct SettingButton: View {

   @Binding var isActive: Bool
    var actionSet: () -> Void
    var actionPhoto: () -> Void
    
    var body: some View {
        VStack(spacing: 15) {
            HStack(spacing: 25)  {
                Button(action: actionSet) {
                    Image.gear
                        .iconSize(size: 30)
                        .rotationEffect(.degrees(isActive ? -90 : 0))
                }
                Spacer()
                Button(action: actionPhoto) {
                    HStack {
                        Text("Show photos")
                            .customFont(size: 16)
                            .fontWeight(.regular)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 16, weight: .bold))
                    }
                    .foregroundColor(.white)
                }
            }
            RoundedRectangle(cornerRadius: 1)
                .fill(Color.b_555555)
                .frame(height: 2)
        }
    }
}


#if DEBUG
struct SettingButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingButton(isActive: .constant(false), actionSet: {}, actionPhoto: {})
    }
}
#endif
