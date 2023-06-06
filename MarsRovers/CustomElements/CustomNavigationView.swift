//
//  CustomNavigationView.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import SwiftUI


struct CustomNavigationView<Content: View>: View {
    
    var title: String
    var height: CGFloat
    var content: Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image.starfield
                .resizable()
                .scaledToFill()
                .frame(maxHeight: height >= 30 ? 90 : 70)
                .mask(Rectangle())
            HStack(spacing: 0) {
                ZStack {
                    Text(title.uppercased())
                        .customFont(size: 22)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    HStack() {
                        content
                            .foregroundColor(.white)
                            .offset(y: 8)
                        Image.logo
                            .iconSize(size: 60)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal, 26)
                }
            }
        }
    }
}



#if DEBUG
struct CustomNavigationView_Previews: PreviewProvider {
    static var previews: some View {
//        CustomNavigationView(title: "Settings", height: 90,
//                             content:         Button(action: {}) {
//            Image(systemName: "chevron.backward")
//                .font(.system(size: 20, weight: .bold))
//        })
        ContentView()
    }
}
#endif
