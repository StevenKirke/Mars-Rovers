//
//  ContentView.swift.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.04.2023.
//

import SwiftUI


struct ContentView: View, WriteRover {
    
    @StateObject  var globalModel: GlobalModel
    @StateObject var calculateSol: CalculateSolModel = CalculateSolModel()
    @ObservedObject var contenVM: ContentVewModel = ContentVewModel()
    
    @State var isSetting: Bool = false
    
    func readingDataRover() {
        
    }
    
    func saveDataRover(_ index: Int) {
        let currentRover = contenVM.rovers.rovers[index]
        self.calculateSol.filterRover.roverName = currentRover.name.lowercased()
        self.calculateSol.filterRover.sol = currentRover.maxSol
        self.calculateSol.filterRover.tempSol = 0
        
        guard let camera = currentRover.cameras.first?.name else {
            return
        }
        self.calculateSol.filterRover.camera = camera
        calculateSol.breakdownWheel(currentRover.maxSol)
    }
    
    var body: some View {
        GeometryReader { geo in
            NavigationView {
                VStack(spacing: 0) {
                    answerView()
                }
                .edgesIgnoringSafeArea(.all)
            }
            .environmentObject(calculateSol)
            .environmentObject(globalModel)
            .onAppear {
                self.globalModel.safeArea = (geo.safeAreaInsets.top, geo.safeAreaInsets.bottom)
            }
        }
    }
    
    
    @ViewBuilder
    private func answerView() -> some View {
        GeometryReader { proxy in
            let heightInfo = proxy.size.height * 0.41
            let heigthCarousel = proxy.size.height * 0.38
            ZStack(alignment: .bottom) {
                VStack(spacing: 10) {
                    if !contenVM.rovers.rovers.isEmpty {
                        let name = isSetting ? "Settings" : contenVM.rovers.rovers[contenVM.currentIndex].name
                        CustomNavigationView(title: name, content: EmptyView())
                        InfinityCarousel(index: $contenVM.currentIndex,
                                         height: heigthCarousel,
                                         views: contenVM.arrayRovers)
                    } else {
                        CustomNavigationView(title: "Settings", content: EmptyView())
                        PlanetAnimation(height: heigthCarousel)
                    }
                    Spacer()
                }
                if !contenVM.rovers.rovers.isEmpty {
                    CardContent(isActive: $contenVM.isActive,
                                isSetting: $isSetting,
                                currentCamera: $contenVM.currentIndex,
                                rover: contenVM.rovers.rovers[contenVM.currentIndex],
                                icon: contenVM.arrayRovers[contenVM.currentIndex].littleImage,
                                height: heightInfo)
                } else {
                    SceletonCardRoverDescription(height: heightInfo)
                }
            }
            .onAppear() {
                if !contenVM.rovers.rovers.isEmpty {
                    saveDataRover(contenVM.currentIndex)
                }
            }
            .onChange(of: contenVM.currentIndex) {
                saveDataRover($0)
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
    
    @Binding var isActive: Bool
    @Binding var isSetting: Bool
    @Binding var currentCamera: Int
    
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
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.b_000000_25)
                    .frame(height: height)
                    .offset(y: -height - 64)
                CardRoverSettings(isSetting: $isSetting,
                                  rover: rover,
                                  height: height * 1.7)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
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

