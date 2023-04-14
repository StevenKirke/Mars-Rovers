//
//  CardRoverDescription.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI

struct CardRoverDescription: View {
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    @Binding var isSetting: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack(spacing: 0) {
                    Image.starfield
                        .resizable()
                    Image.starfield
                        .resizable()
                        .rotationEffect(.degrees(180))
                }
                .mask(RoundedRectangle(cornerRadius: 13))
                VStack(spacing: 10) {
                    SettingButton(isActive: $isSetting, actionSet: {
                        var transaction = Transaction(animation: .easeInOut(duration: 1))
                        transaction.disablesAnimations = true
                        withTransaction(transaction) {
                            self.isSetting.toggle()
                        }
                    }, actionPhoto: {
                        
                    })
                    LabelRover(title: "Launch date", data: rover.launchDate.convertDate(), image: .rocked)
                    LabelRover(title: "Landing date", data: rover.landingDate.convertDate(), image: .parachute)
                    LabelRover(title: "Max sol", data: "\(rover.maxSol)", image: .sun)
                    LabelRover(title: "Total photos", data: "\(rover.totalPhotos)", image: .pictures)
                    LabelRover(title: "Status", data: rover.status, image: icon)
                    LabelRover(title: "Cameras", data: "\(rover.cameras.count)", image: .camera)
                }
                .coordinateSpace(name: "ButtonBlock")
                .padding(.horizontal, 26)
                .padding(.top, 15)
                .foregroundColor(.white)
            }
            .offset(y: !isSetting ? (height / 2) : 0)
        }
        .frame(height: height * 1.5)
    }
}


#if DEBUG
struct CardRoverDescription_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
