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
    
    var filter: Filter
    @Binding var isSetting: Bool
    
    var body: some View {
        GeometryReader { proxy in
           // ZStack(alignment: .top) {
             //   VStack(spacing: 0) {
                   // Image.starfield
                    //    .resizable()
             //   }
              //  .mask(RoundedRectangle(cornerRadius: 13))
                VStack(spacing: 10) {
                    HStack(spacing: 25)  {
                        Button(action: {
                            var transaction = Transaction(animation: .easeInOut(duration: 1))
                            transaction.disablesAnimations = true
                            withTransaction(transaction) {
                                self.isSetting.toggle()
                            }
                        }) {
                            HStack(spacing: 25) {
                                Image.gear
                                    .iconSize(size: 30)
                                    .rotationEffect(Angle(degrees: isSetting ? -90 : 0))
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("\(filter.roverName)")
                                        .customFont(size: 8)
                                        .fontWeight(.regular)
                                    Text("\(String(filter.sol))")
                                        .customFont(size: 8)
                                        .fontWeight(.regular)
                                    Text("\(filter.camera)")
                                        .customFont(size: 8)
                                        .fontWeight(.regular)
                                }
                            }
                        }
                        Spacer()
                        Button(action: {
                            print("Show Photo")
                            print("\(filter)")
                        }) {
                            HStack {
                                Text("Show photos")
                                    .customFont(size: 16)
                                    .fontWeight(.regular)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .bold))
                            }
                            .foregroundColor(.white)
                        }
                    }
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.b_555555)
                        .frame(height: 2)
                    LabelRover(title: "Launch date", data: rover.launchDate.convertDate(), image: .rocked)
                    LabelRover(title: "Landing date", data: rover.landingDate.convertDate(), image: .parachute)
                    LabelRover(title: "Max sol", data: "\(rover.maxSol)", image: .sun)
                    LabelRover(title: "Total photos", data: "\(rover.totalPhotos)", image: .pictures)
                    LabelRover(title: "Status", data: rover.status, image: icon)
                    LabelRover(title: "Cameras", data: "\(rover.cameras.count)", image: .camera)
                }
                .padding(.horizontal, 26)
                .padding(.top, 15)
                .foregroundColor(.white)
          //  }
        }
        .frame(height: height)
        .background( Image.starfield
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

