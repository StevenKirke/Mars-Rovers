//
//  EarthAnim.swift
//  MarsRovers
//
//  Created by Steven Kirke on 03.06.2023.
//

import SwiftUI

struct PlanetAnim: View {
    
    @Binding var isEarthCart: Bool
    @Binding var scale: CGFloat
    
    var image: Image = Image.earthCartAnim
    var radius: CGFloat = 150.0
    var tiltAngle: Double = 23.44
    
    var body: some View {
            ZStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: radius)
                    .background(.gray)
                    .foregroundColor(.black)
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: radius)
                    .background(.gray)
                    .foregroundColor(.black)
                    .offset(x: -radius)
            }
            .offset(x: isEarthCart ? radius : 0)
            .animation(anim(), value: isEarthCart)
            .mask(
                Circle()
                    .fill()
            )
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
                    .shadow(color: .black, radius: 5, x: 0, y: 0)
                    .mask(Circle())
            )
            .frame(width: radius, height: radius)
            .scaleEffect(x: scale, y: scale)
            .rotationEffect(Angle(degrees: tiltAngle))
    }
    
    private func anim() -> Animation {
        return
            .linear(duration: 6)
            .repeatForever(autoreverses: false)
    }
    
    private func animRepeat() -> Animation {
        return
            .linear(duration: 4)
            .repeatForever(autoreverses: true)
    }
}

#if DEBUG
struct PlanetAnim_Previews: PreviewProvider {
    static var previews: some View {
        PlanetAnim(isEarthCart: .constant(false), scale: .constant(1.0), radius: 250)
    }
}
#endif
