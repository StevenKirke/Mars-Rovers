//
//  ContentView.swift.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.04.2023.
//

import SwiftUI


struct ContentView: View, WriteRover {
    
    @StateObject var calculateSol: CalculateSolModel = CalculateSolModel()
    @ObservedObject var contenVM: ContentVewModel = ContentVewModel()
    
    @State var isSetting: Bool = false
    @State var isBlind: Bool = false
    
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
        NavigationView {
            VStack(spacing: 0) {
                if contenVM.arrayRovers.isEmpty {
                    Text("1")
                } else {
                    answerView()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .environmentObject(calculateSol)
    }
    
    
    @ViewBuilder
    func answerView() -> some View {
        GeometryReader { proxy in
            let saveAreaTop = proxy.safeAreaInsets.top
            let heightInfo = proxy.size.height * 0.41
            let heigthCarousel = proxy.size.height - heightInfo - 180
            ZStack(alignment: .bottom) {
                VStack(spacing: 19) {
                    CustomNavigationView(title: isSetting ? "Settings" : contenVM.rovers.rovers[contenVM.currentIndex].name, height: saveAreaTop, content: EmptyView())
                        .border(.red)
                    InfinityCarousel(index: $contenVM.currentIndex,
                                     height: heigthCarousel + saveAreaTop,
                                     views: contenVM.arrayRovers)
                    .border(.blue)
                    Spacer()
                    
                }
                .offset(y: -saveAreaTop)
                //.offset(y: -saveAreaTop)
                CardContent(isSetting: $isSetting, currentCamera: $contenVM.currentIndex,
                            rover: contenVM.rovers.rovers[contenVM.currentIndex],
                            icon: contenVM.arrayRovers[contenVM.currentIndex].littleImage,
                            height: heightInfo)
            }
            .onAppear() {
                print(proxy.safeAreaInsets.top)
                print(proxy.safeAreaInsets.bottom)
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

struct CardContent: View {
    
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
                // .opacity(isSetting ? 1 : 0)
                CardRoverSettings(isSetting: $isSetting,
                                  rover: rover,
                                  height: height * 1.7)
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: changeOffset())
        .animation(anim(), value: isSetting)
    }
    
    private func changeOffset() -> CGFloat {
        let width = UIScreen.main.bounds.width / 2
        return !isSetting ? width : -width
    }
    
    private func showBlind() {
        print("height - \(height)")
    }
    
    private func anim() -> Animation {
        return
            .easeInOut(duration: 1.5)
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
