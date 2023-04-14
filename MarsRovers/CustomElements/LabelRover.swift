//
//  LabelRover.swift
//  MarsRovers
//
//  Created by Steven Kirke on 13.04.2023.
//

import SwiftUI

struct LabelRover: View {
    var title: String
    var data: String
    var image: Image
    
    var body: some View {
        HStack(spacing: 25) {
            image
                .iconSize(size: 30)
            Text(title)
                .customFont(size: 16)
                .fontWeight(.bold)
            Spacer()
            Text(data)
                .customFont(size: 16)
                .fontWeight(.bold)
        }
    }
}

#if DEBUG
struct LabelRover_Previews: PreviewProvider {
    static var previews: some View {
        LabelRover(title: "Status", data: "active", image: .iconCuriosity)
    }
}
#endif
