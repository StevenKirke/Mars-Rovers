//
//  ContentView.swift.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.04.2023.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var contenVM: ContentVewModel = ContentVewModel()
    
    @State var currentIndex: Int = 0
    @State var isSetting: Bool = true
    
    var title: String {
        isSetting ? "Settings" : contenVM.rovers.rovers[currentIndex].name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            answerView()
        }
        .edgesIgnoringSafeArea(.vertical)
    }
    
    @ViewBuilder
    func answerView() -> some View {
        if contenVM.arrayRovers.isEmpty {
            Text("1")
        } else {
            GeometryReader { proxy in
                let heightInfo = proxy.size.height * 0.41
                let heigthCarousel = proxy.size.height - heightInfo - 180
                
                ZStack(alignment: .bottom) {
                    VStack(spacing: 19) {
                        CustomNavigationView(title: title,
                                             content: EmptyView())
                        .transaction { tr in
                            tr.animation = nil
                        }
                        InfinityCarousel(index: $currentIndex, height: heigthCarousel,
                                         views: contenVM.arrayRovers)
                        Spacer()
                    }
                    /*
                    CardRoverDescription(rover: contenVM.rovers.rovers[currentIndex],
                                         icon: contenVM.arrayRovers[currentIndex].littleImage,
                                         height: heightInfo,
                                         isSetting: $isSetting)
                    */
                    CardRoverSettings(rover: contenVM.rovers.rovers[currentIndex],
                                      icon: contenVM.arrayRovers[currentIndex].littleImage,
                                      height: heightInfo,
                                      isSetting: $isSetting)
                }
            }
        }
    }
}

struct CardRoverSettings: View {
    
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
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

/*
 var transaction = Transaction(animation: .easeInOut(duration: 1))
 transaction.disablesAnimations = true
 withTransaction(transaction) {
 self.isSetting.toggle()
 }
 */
