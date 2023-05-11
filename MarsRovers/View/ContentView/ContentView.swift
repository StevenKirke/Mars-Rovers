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
            .edgesIgnoringSafeArea(.vertical)
        }
        .environmentObject(calculateSol)
    }
    
    
    @ViewBuilder
    func answerView() -> some View {
        GeometryReader { proxy in
            let heightInfo = proxy.size.height * 0.41
            let heigthCarousel = proxy.size.height - heightInfo - 180
            ZStack(alignment: .bottom) {
                VStack(spacing: 19) {
                    CustomNavigationView(title: isSetting ? "Settings" : contenVM.rovers.rovers[contenVM.currentIndex].name,
                                         content: EmptyView())
                    InfinityCarousel(index: $contenVM.currentIndex,
                                     height: heigthCarousel,
                                     views: contenVM.arrayRovers)
                    Spacer()
                    
                }
                CardContent(isSetting: $isSetting, currentCamera: $contenVM.currentIndex,
                            rover: contenVM.rovers.rovers[contenVM.currentIndex],
                            icon: contenVM.arrayRovers[contenVM.currentIndex].littleImage,
                            height: heightInfo)
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

struct CardContent: View {
    
    @Binding var isSetting: Bool
    @Binding var currentCamera: Int
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(Color.red)
                .frame(width: UIScreen.main.bounds.width, height: height)
                .mask(RoundedRectangle(cornerRadius: 13))
                .offset(y: !isSetting ? 0 : 300)
            HStack(alignment: .bottom, spacing: 0) {
                CardRoverDescription(isSetting: $isSetting,
                                     rover: rover,
                                     icon: icon,
                                     height: height)
                .frame(width: UIScreen.main.bounds.width)
                CardRoverSettings(isSetting: $isSetting,
                                  rover: rover,
                                  height: height)
                .frame(width: UIScreen.main.bounds.width)
            }
            .frame(width: UIScreen.main.bounds.width)
            .offset(x: changeOffset())
            .animation(.linear(duration: 1), value: isSetting)
        }
    }
    
    private func changeOffset() -> CGFloat {
        let width = UIScreen.main.bounds.width / 2
        return !isSetting ? width : -width
    }
    
    private func showBlind() {
        print("height - \(height)")
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
