//
//  EllipseTest.swift
//  MarsRovers
//
//  Created by Steven Kirke on 09.06.2023.
//

import SwiftUI



struct RotateObjectInEllipsePath: View {
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    let a: CGFloat = 250.0
    let b: CGFloat = 250
    
    @State private var angle: Double = .zero
    
    @State private var ellipseX: CGFloat = .zero
    @State private var ellipseY: CGFloat = .zero
    
    var body: some View {
        VStack {
            Circle()
                .strokeBorder(Color.red, lineWidth: 2)
                .frame(width: a, height: a)
                .overlay(
                    Image(systemName: "arrow.down")
                        .offset(x: a/2)
                        .rotationEffect(.degrees(angle))
                )
                
            Spacer()
                .frame(height: 60)
            
            Ellipse()
                .strokeBorder(Color.red, lineWidth: 2)
                .frame(width: a, height: b)
                .overlay(
                    Image(systemName: "arrow.down")
                        .rotationEffect(.degrees(angle))
                        .offset(x: ellipseX, y: ellipseY)
                )
            
            Spacer()
                .frame(height: 40)
        }// VStack
        .animation(.default)
        .onReceive(timer) { _ in
            angle += 1
            let theta = CGFloat(.pi * angle / 180)
            ellipseX = a / 2 * cos(theta)
            ellipseY = b / 2 * sin(theta)
        }
    }
    
}

struct RotateObjectInEllipsePath_Previews: PreviewProvider {
    static var previews: some View {
        RotateObjectInEllipsePath()
    }
}
