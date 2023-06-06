//
//  EarthAnim.swift
//  MarsRovers
//
//  Created by Steven Kirke on 03.06.2023.
//

import SwiftUI

struct EarthAnim: View {
    
    @State var isEarthCart: Bool = false
    var sizeRover: CGFloat
    
    var body: some View {
            ZStack {
                Image.earthCartAnim
                    .resizable()
                    .scaledToFit()
                    .frame(width: sizeRover)
                    .onAppear() {
                        DispatchQueue.main.async {
                            self.isEarthCart.toggle()
                        }
                    }
                Image.earthCartAnim
                    .resizable()
                    .scaledToFit()
                    .frame(width: sizeRover)
                    .offset(x: sizeRover)
            }
            .offset(x: isEarthCart ? -sizeRover : 0)
            .animation(anim(), value: isEarthCart)
            .mask(
                Circle()
                    .fill()
            )
            .overlay(
                Circle()
                    .stroke(lineWidth: 2)
                    .shadow(color: .black, radius: 5, x: 0, y: 0)
                    .mask(Circle())
            )
    }
    
    private func anim() -> Animation {
        return
            .linear(duration: 5)
            .repeatForever(autoreverses: false)
    }
}


struct EarthAnim_Previews: PreviewProvider {
    static var previews: some View {
        EarthAnim(sizeRover: 120)
    }
}
