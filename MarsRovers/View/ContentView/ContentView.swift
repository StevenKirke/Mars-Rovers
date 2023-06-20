//
//  ContentView.swift.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.04.2023.
//

import SwiftUI


struct ContentView: View, WriteRover {
        
    @StateObject  var globalModel: GlobalModel
    @StateObject var calculateRover: CalculateRoverSettingModel = CalculateRoverSettingModel()
    
    @ObservedObject var contenVM: ContentVewModel = ContentVewModel()
    
    func saveDataRover(_ index: Int) {
        let currentRover = contenVM.rovers.rovers[index]
        self.calculateRover.currentRover.roverName = currentRover.name.lowercased()
        self.calculateRover.currentRover.sol = currentRover.maxSol
        self.calculateRover.currentRover.tempSol = 0
        
        guard let camera = currentRover.cameras.first?.name else {
            return
        }
        self.calculateRover.currentRover.camera = camera
        calculateRover.breakdownWheel(currentRover.maxSol)
    }
    
    var body: some View {
        GeometryReader { proxy in
            let heightCard = proxy.size.height * 0.41 + proxy.safeAreaInsets.top
            let heigthCarousel = proxy.size.height * 0.38
            NavigationView {
                ZStack(alignment: .bottom) {
                    VStack(spacing: 10) {
                        CustomNavigationView(title: contenVM.title, content: EmptyView())
                        if contenVM.isStart {
                            InfinityCarousel(index: $contenVM.currentIndex,
                                             height: heigthCarousel,
                                             views: contenVM.roverIcons)
                        } else {
                            PlanetAnimation(height: heigthCarousel)
                        }
                        Spacer()
                    }
                    if contenVM.isStart {
                        CardContent(rover: contenVM.rovers.rovers[contenVM.currentIndex],
                                    icon: contenVM.roverIcons[contenVM.currentIndex].icon,
                                    height: heightCard)
                    } else {
                        SceletonCardRoverDescription(height: heightCard)
                        
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            .environmentObject(calculateRover)
            .environmentObject(globalModel)
            .onAppear {
                self.globalModel.safeArea = (proxy.safeAreaInsets.top, proxy.safeAreaInsets.bottom)
            }
            .onChange(of: contenVM.currentIndex) {
                saveDataRover($0)
            }
            .onChange(of: contenVM.isStart) { isStart in
                if isStart == true {
                    saveDataRover(0)
                } else {
                    
                }
            }
        }
    }
}


struct PlanetAnimation: View  {
    
    var height: CGFloat
    
    var precent: CGFloat {
        (80 * height) / 100
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.b_555555_30)
                    .frame(width: UIScreen.main.bounds.width  / 4, height: precent)
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.b_555555_30)
                    .frame(width: UIScreen.main.bounds.width  / 4, height: precent)
            }
            .offset(y: 25)
            VStack(spacing: 0) {
                OrbitGenerate()
            }
            .frame(width: UIScreen.main.bounds.width - 52, height: height)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray)
            )
            .cornerRadius(10)
        }
    }
}

struct CardContent: View {
    
    @State var isSetting: Bool = false
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            CardRoverDescription(isSetting: $isSetting,
                                 rover: rover,
                                 icon: icon,
                                 height: height)
            .frame(width: UIScreen.main.bounds.width)
            CardRoverSettings(isSetting: $isSetting,
                              rover: rover,
                              height: height * 1.7)
            .frame(maxWidth: UIScreen.main.bounds.width)
        }
        .frame(maxWidth: UIScreen.main.bounds.width * 2)
        .offset(x: changeOffset())
        .animation(anim(), value: isSetting)
    }
    
    private func changeOffset() -> CGFloat {
        let width = UIScreen.main.bounds.width / 2
        return !isSetting ? width : -width
    }
    
    private func anim() -> Animation {
        .easeInOut(duration: 1.5)
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(globalModel: GlobalModel())
    }
}
#endif
