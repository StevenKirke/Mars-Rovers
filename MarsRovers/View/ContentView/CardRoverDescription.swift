//
//  CardRoverDescription.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI


struct CardRoverDescription: View {
    
    @EnvironmentObject var calculateSol: CalculateSolModel

    @Binding var isSetting: Bool
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                HStack(spacing: 25) {
                    Spacer()
                    GearButton(rotate: isSetting ? -90 : 0) {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.isSetting.toggle()
                            }
                        }
                    }
                }
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.b_555555)
                    .frame(height: 2)
                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        LabelRover(title: "Launch date:",
                                   data: rover.launchDate.convertDate(),
                                   image: .rocked)
                        LabelRover(title: "Landing date:",
                                   data: rover.landingDate.convertDate(),
                                   image: .parachute)
                        LabelRover(title: "Max sol:",
                                   data: "\(rover.maxSol)",
                                   image: .sun)
                        LabelRover(title: "Total photos:",
                                   data: "\(rover.totalPhotos)",
                                   image: .pictures)
                        LabelRover(title: "Status:",
                                   data: rover.status,
                                   image: icon)
                        LabelRover(title: "Number of cameras:",
                                   data: "\(rover.cameras.count)",
                                   image: .camera)
                    }
                    
                }
            }
            .padding(.horizontal, 26)
            .padding(.top, 15)
            .foregroundColor(.white)
        }
        .frame(height: height)
        .background(Image.starfield
            .resizable()
            .mask(
                RoundedCornersShape(corners: [.topLeft, .topRight], radius: 13)
                    .fill(Color.white))
        )
    }
}

struct SceletonCardRoverDescription: View {
    
    var height: CGFloat
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 10) {
                HStack(spacing: 25) {
                    Spacer()
                    GearButton(rotate: 0, action: {})
                }
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.b_555555)
                    .frame(height: 2)
                VStack(spacing: 16) {
                    ForEach(0...4, id: \.self) { elem in
                        Sceleton(heighContainer: 30, widthContainer: UIScreen.main.bounds.width - 52)
                    }
                }
            }
            .padding(.horizontal, 26)
            .padding(.top, 15)
            .foregroundColor(.white)
        }
        .frame(height: height)
        .background(Image.starfield
            .resizable()
            .mask(
                RoundedCornersShape(corners: [.topLeft, .topRight], radius: 13)
                    .fill(Color.white))
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
        SceletonCardRoverDescription(height: 300)
        //        CardRoverDescription(isSetting: .constant(true),
        //                             rover: testRover,
        //                             icon: .iconPerseverance,
        //                             height: 300)
    }
}

var testRover = Rover(id: 8,
                      name: "Perseverance",
                      landingDate: "2021-02-18",
                      launchDate: "2020-07-30",
                      status: "active",
                      maxSol: 761,
                      maxDate: "2023-04-10",
                      totalPhotos: 147898, cameras: testCameras)

var testCameras = [Camera(id: 33,
                          name: "EDL_RUCAM",
                          roverID: 8,
                          fullName: "Rover Up-Look Camera"),
                   Camera(id: 36,
                          name: "EDL_PUCAM1",
                          roverID: 8,
                          fullName: "Parachute Up-Look Camera A"),
                   Camera(id: 37,
                          name: "EDL_PUCAM2",
                          roverID: 8,
                          fullName: "Parachute Up-Look Camera B"),
                   Camera(id: 38,
                          name: "NAVCAM_LEFT",
                          roverID: 8,
                          fullName: "Navigation Camera - Left")]
#endif
