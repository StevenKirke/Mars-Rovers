//
//  RoverConnection.swift
//  MarsRovers
//
//  Created by Steven Kirke on 02.05.2023.
//

import SwiftUI


struct CardRoverConnect: View {
    
    var sizeRover: CGFloat = 120
    
    @State var scaleRover: Double = 0.5
    @State var scale: CGFloat = 1
    
    var body: some View {
        HStack(spacing: 0) {
            RoverConnection(sizeRover: sizeRover)
                .scaleEffect(scaleRover, anchor: .bottom)
                .onAppear() {
                    DispatchQueue.main.async {
                        withAnimation(anim()) {
                            self.scaleRover = 0.8
                        }
                    }
                }
            Spacer()
            EarthAnim(scale: $scale, image: Image.marsCartAnim, radius: sizeRover)
                .offset(x: 0, y: -sizeRover / 3)
        }
        .padding(.horizontal, 20)
        .frame(width: 300, height: 200)
        .padding(.horizontal, 10)
        .background(Color.gray)
        .cornerRadius(13)
    }
    
    private func anim() -> Animation {
        return
            .easeInOut(duration: 3)
            .delay(3)
    }
}


struct RoverConnection: View {
    
    @State var geoG: CGRect = .zero
    @State var roverG: CGRect = .zero
    @State var roverL: CGRect = .zero
    
    var sizeRover: CGFloat
    
    @State var rotate: Double = 0.0
    
    @State var isAnin: Bool = false
    
    var offsetRover: CGPoint = .init(x: 0, y: 0)
    
    
    var body: some View {
        ZStack {
            GeometryReader { roverGeo in
                Image.roverAnim
                    .resizable()
                    .scaledToFit()
                    .onAppear() {
                        self.roverL = roverGeo.frame(in: .local)
                        self.roverG = roverGeo.frame(in: .global)
                        DispatchQueue.main.async {
                            withAnimation(anim()) {
                                self.rotate = 72
                            }
                        }
                    }
            }
            .frame(width: sizeRover, height: sizeRover)
            Aerial(isAnim: $isAnin, roverL: $roverL)
                .frame(width: sizeRover / 3, height: sizeRover / 3)
                .rotationEffect(Angle(degrees: rotate), anchor: .bottom)
                .animationObserver(for: rotate, onComplete: {
                    self.isAnin = true
                })
                .position(x: roverL.midX + precent(14), y: roverL.minY + sizeRover / 5 )
        }
        .frame(width: sizeRover, height: sizeRover)
    }
    
    
    private func precent(_ multiplay: CGFloat) -> CGFloat {
        sizeRover / 100 * multiplay
    }
    
    private func anim() -> Animation {
        return
            .easeInOut(duration: 3)
            .delay(3)
    }
}

struct Aerial: View {
    
    @Binding var isAnim: Bool
    @Binding var roverL: CGRect
    
    var body: some View {
        GeometryReader { geo in
            let geoA = geo.frame(in: .local)
            ZStack {
                Image.aerialAnim
                    .resizable()
                    .scaledToFit()
                ForEach(1..<4) { elem in
                    let multiplier = Double(elem) * 0.5
                    CircleAnimation(isAnim: $isAnim, delay: multiplier)
                }
                .position(x: roverL.minX + (geoA.width / 2))
            }
        }
    }
}


struct CircleAnimation: View {
    
    @Binding var isAnim: Bool
    @State var radius: CGFloat = 150
    
    var delay: Double
    
    var body: some View {
        Circle()
            .trim(from: 0.65, to: 0.8)
            .stroke(Color.black)
            .opacity(isAnim ? 0 : 1)
            .frame(width: isAnim ? radius : 0, height: isAnim ? radius : 0)
            .animation(anim(delay), value: isAnim)
    }
    
    private func anim(_ delay: Double) -> Animation {
        return
            .easeInOut(duration: 3)
            .repeatForever(autoreverses: false)
            .delay(delay)
    }
}




struct RoverConnection_Previews: PreviewProvider {
    static var previews: some View {
        CardRoverConnect()
    }
}



