//
//  CustomNavigationView.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.04.2023.
//

import SwiftUI


struct CustomNavigationView<Content: View>: View {
    
    @EnvironmentObject var settings: GlobalModel
    
    var title: String
    var content: Content
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image.starfield
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 70 + settings.safeArea.top)
                .mask(Rectangle())
            HStack(spacing: 0) {
                ZStack {
                    Text(title.uppercased())
                        .customFont(size: 22)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 15)
                    HStack(spacing: 0) {
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
struct ViewButtom: View {
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct CustomNavigationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CustomNavigationView(title: "Settings",
                             content: ViewButtom(action: {})
        )
        .environmentObject(GlobalModel())
    }
}
#endif
