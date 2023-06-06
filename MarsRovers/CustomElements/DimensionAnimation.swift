//
//  DimensionAnimation.swift
//  MarsRovers
//
//  Created by Steven Kirke on 05.06.2023.
//

import SwiftUI

struct DimensionAnimation: View {
    
    var radius: CGFloat = 150
    
    @State var dimentionLitte: Int = 0
    @State var dimentionBig: Int = 0
    
    @State var rotate: Double = 0.0
    @State var rotateLittle: Double = 0.0
    @State var rotateBig: Double = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 1)
                    .frame(width: radius)
                   //.rotation3DEffect(.degrees(80), axis: (x: 1, y: 0, z: 0))

                HStack {
                    Circle()
                        .trim(from: 0.0, to: 0.75)
                        .stroke(Color.red, lineWidth: 2)
                        .rotation3DEffect(.degrees(rotateLittle), axis: chechStep(step: dimentionLitte))

                }
                .frame(width: 20, height: 20)
                .border(.green)
                .rotation3DEffect(.degrees(0), axis: (x: 1, y: 0, z: 0))
                .offset(x: radius / 2)
                .rotationEffect(.degrees(rotate))
                    
            }
            .rotation3DEffect(.degrees(rotateBig), axis: chechStep(step: dimentionBig))
            Stepper(value: $dimentionLitte, in: 0...3) {
                Text("Dimention litte \(dimentionLitte)")
                    .font(.system(size: 10))
            }
            Stepper(value: $dimentionBig, in: 0...3) {
                Text("Dimention big \(dimentionBig)")
                    .font(.system(size: 10))
            }
            VStack(alignment: .trailing, spacing: 0) {
                HStack {
                    Text("RotateLittle \(Int(rotateLittle))")
                        .frame(width: 120)
                        .font(.system(size: 10))
                    Slider(value: $rotateLittle, in: -180...180)
                }
                HStack {
                    Text("RotateBig \(Int(rotateBig))")
                        .frame(width: 120)
                        .font(.system(size: 10))
                    Slider(value: $rotateBig, in: -180...180)
                }
                HStack {
                    Text("Rotate \(Int(rotate))")
                        .frame(width: 120)
                        .font(.system(size: 10))
                        .multilineTextAlignment(.leading)
                    Slider(value: $rotate, in: 0...360)
                }
            }
            .padding(.horizontal, 10)
        }
    }
    
    func chechStep(step: Int) -> (x: CGFloat, y: CGFloat, z: CGFloat) {
        switch step {
            case 0:
                return (x: 0, y: 0, z: 0)
            case 1:
                return (x: 1, y: 0, z: 0)
            case 2:
                return (x: 0, y: 1, z: 0)
            case 3:
                return (x: 0, y: 0, z: 1)
            default:
                return (x: 0, y: 0, z: 0)
        }
    }
}

struct DimensionAnimation_Previews: PreviewProvider {
    static var previews: some View {
        DimensionAnimation()
    }
}
