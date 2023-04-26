//
//  CardRoverDescription.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI


struct CardRoverDescription: View {
    
    @Binding var isSetting: Bool
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                HStack(spacing: 25)  {
                    Button(action: {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.isSetting.toggle()
                            }
                        }
                    }) {
                        HStack(spacing: 25) {
                            Image.gear
                                .iconSize(size: 30)
                                .rotationEffect(Angle(degrees: isSetting ? -90 : 0))
                        }
                    }
                    Spacer()
                }
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.b_555555)
                    .frame(height: 2)
                LabelRover(title: "Launch date",
                           data: rover.launchDate.convertDate(),
                           image: .rocked)
                LabelRover(title: "Landing date",
                           data: rover.landingDate.convertDate(),
                           image: .parachute)
                LabelRover(title: "Max sol",
                           data: "\(rover.maxSol)",
                           image: .sun)
                LabelRover(title: "Total photos",
                           data: "\(rover.totalPhotos)",
                           image: .pictures)
                LabelRover(title: "Status",
                           data: rover.status,
                           image: icon)
                LabelRover(title: "Number of cameras",
                           data: "\(rover.cameras.count)",
                           image: .camera)
            }
            .padding(.horizontal, 26)
            .padding(.top, 15)
            .foregroundColor(.white)
        }
        .frame(height: height)
        .background(Image.starfield
            .resizable()
            .mask(RoundedRectangle(cornerRadius: 13))
        )
    }
}

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
struct CardRoverDescription_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

