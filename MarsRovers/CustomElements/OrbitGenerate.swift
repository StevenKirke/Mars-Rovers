//
//  OrbitGenerate.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.06.2023.
//

import SwiftUI


struct OrbitGenerate: View {
    
    @State var isAnimation: Bool = false
    
    @State var angleEarth: Double = 0.0
    @State var angleMars: Double = 0.0
    
    @State var coordinateEarthX: CGFloat = 75
    @State var coordinateEarthY: CGFloat = 0.0
    
    @State var coordinateMarsX: CGFloat = 125
    @State var coordinateMarsY: CGFloat = 0.0
    
    @State var scaleEarth: CGFloat = 1.0
    @State var scaleMars: CGFloat = 1.0
    
    var multiplay: CGFloat = 0.25
    var radius: CGFloat = 150
    var gradientSun: Gradient = .init(colors: [.yellow, .yellow.opacity(1), .yellow.opacity(0.0)])
    
    var body: some View {
        ZStack {
            Circle()
                .opacity(0)
                .overlay(Circle()
                    .trim(from: 0.0, to: 0.5)
                    .fill(RadialGradient(gradient: Gradient(colors: [.yellow, .yellow.opacity(1), .yellow.opacity(0.0)]),
                                         center: .center,
                                         startRadius: 1,
                                         endRadius: radius / 4))
                )
                .scaleEffect(0.8)
                .frame(width: radius / 2)
            Circle()
                .fill(RadialGradient(gradient: gradientSun,
                                     center: .center,
                                     startRadius: 1,
                                     endRadius: radius / 4))
                .frame(width: radius / 2)
                .rotationEffect(Angle(degrees: angleEarth))
                .scaleEffect(0.9)
                .animationObserver(for: angleEarth) { value in
                    let (earthX, earthY) = orbitPlanet(radius: radius, angle: value)
                    self.coordinateEarthX = earthX
                    self.coordinateEarthY = earthY
                    self.scaleEarth = scalePlanet(angle: value)
                }
                .animationObserver(for: angleMars) { value in
                    let (marsX, marsY) = orbitPlanet(radius: radius + 125, angle: value)
                    self.coordinateMarsX = marsX
                    self.coordinateMarsY = marsY
                    self.scaleMars = scalePlanet(angle: value)
                }
            ForEach(0...360, id: \.self) {
                let convert = Double($0)
                if convert.truncatingRemainder(dividingBy: 5) == 0 {
                    let (x, y) = calculateOrbit(radius: radius, angle: Double($0))
                    Circle()
                        .fill(.black)
                        .frame(width: 1, height: 1)
                        .offset(x: x, y: y)
                }
            }
            PlanetAnim(isEarthCart: $isAnimation,
                       scale: $scaleEarth,
                       radius: 50)
            .offset(x: coordinateEarthX, y: coordinateEarthY)
            ForEach(0...360, id: \.self) {
                let convert = Double($0)
                if convert.truncatingRemainder(dividingBy: 2.5) == 0 {
                    let (x, y) = calculateOrbit(radius: radius + 125, angle: Double($0))
                    Circle()
                        .fill(.black)
                        .frame(width: 1, height: 1)
                        .offset(x: x, y: y)
                }
            }
            PlanetAnim(isEarthCart: $isAnimation,
                       scale: $scaleMars,
                       image: Image.marsCartAnim,
                       radius: 40,
                       tiltAngle: 25.1)
            .offset(x: coordinateMarsX, y: coordinateMarsY)
            Circle()
                .opacity(0)
                .overlay(Circle()
                    .trim(from: 0.5, to: 1.0)
                    .fill(RadialGradient(gradient: Gradient(colors: [.yellow, .yellow.opacity(1), .yellow.opacity(0.0)]),
                                         center: .center,
                                         startRadius: 1,
                                         endRadius: radius / 4))
                )
                .scaleEffect(0.8)
                .frame(width: radius / 2)
        }
        .onAppear() {
            DispatchQueue.main.async {
                self.isAnimation = true
                withAnimation(anim(7)) {
                    self.angleEarth = 360
                }
                withAnimation(anim(16)) {
                    self.angleMars = 360
                }
            }
        }
        .onDisappear() {
            self.isAnimation = true
            self.angleEarth = 0
            self.angleMars = 0
        }
    }
    
    
    private func anim(_ duration: Double) -> Animation {
        .linear(duration: duration)
        .repeatForever(autoreverses: false)
    }
    
    private func animStop() -> Animation {
        .linear(duration: 0)
    }
    
    private func cosinus(_ angle: Double) -> Double {
        cos(angle * Double.pi / 180)
    }
    
    private func sinus(_ angle: Double) -> Double {
        sin(angle * Double.pi / 180)
    }
    
    private func scalePlanet(angle: Double) -> Double {
        let trajectory = round(sinus(angle) * 10) / 10.0
        return transformAngle(trajectory)
    }
    
    private func orbitPlanet(radius: CGFloat, angle: Double) -> (CGFloat, CGFloat) {
        let x = (radius / 2) * cosinus(angle)
        let y = (radius / 2) * sinus(angle) * multiplay
        return (x, y)
    }
    
    private func calculateOrbit(radius: CGFloat, angle: Double) -> (CGFloat, CGFloat) {
        let x = (radius / 2) * cosinus(angle)
        let y = (radius / 2) * sinus(angle) * multiplay
        return (x, y)
    }
    
    private func calculateOrbitY(radius: CGFloat, angle: Double) -> CGFloat {
        (radius / 2) * sinus(angle) * multiplay
    }
    
    private func transformAngle(_ currentNumber: Double) -> Double {
        let initialMin: Double = -1.0
        let initialMax: Double = 1.0
        
        let desiredMin: Double = 0.5
        let desiredMax: Double = 1.0
        
        let rangeAngle = initialMax - initialMin
        let rangeNumber = desiredMax - desiredMin
        
        return ((currentNumber - initialMin) * rangeNumber / rangeAngle) + desiredMin
    }
}

#if DEBUG
struct OrbitGenerate_Previews: PreviewProvider {
    static var previews: some View {
        OrbitGenerate()
    }
}
#endif



