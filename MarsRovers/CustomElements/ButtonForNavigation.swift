//
//  ButtonForNavigation.swift
//  MarsRovers
//
//  Created by Steven Kirke on 02.05.2023.
//

import SwiftUI

struct ButtonForNavigation: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

#if DEBUG
struct ButtonForNavigation_Previews: PreviewProvider {
    static var previews: some View {
        ButtonForNavigation(action: {})
    }
}
#endif
