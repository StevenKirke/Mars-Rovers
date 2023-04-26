//
//  ContentView.swift.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.04.2023.
//

import SwiftUI


protocol WriteRover {
    
    func readingDataRover()
    
    func saveDataRover(_ index: Int)
    
}



struct ContentView: View, WriteRover {
    
    @StateObject var calculateSol: CalculateSolModel = CalculateSolModel()
    @ObservedObject var contenVM: ContentVewModel = ContentVewModel()
    
    func readingDataRover() {
        print("READING")
    }
    
    func saveDataRover(_ index: Int) {
        let currentRover = contenVM.rovers.rovers[index]
        self.calculateSol.filterRover.roverName = currentRover.name
        self.calculateSol.filterRover.sol = currentRover.maxSol
        
        guard let camera = currentRover.cameras.first?.name else {
            return
        }
        self.calculateSol.filterRover.camera = camera
        
        calculateSol.breakdownWheel(currentRover.maxSol)
    }
    

    @State var isSetting: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            answerView()
        }
        .edgesIgnoringSafeArea(.vertical)
        .environmentObject(calculateSol)
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
                        CustomNavigationView(title: isSetting ? "Settings" : contenVM.rovers.rovers[contenVM.currentIndex].name,
                                             content: EmptyView())
                        ZStack(alignment: .topLeading) {
                            InfinityCarousel(index: $contenVM.currentIndex,
                                             height: heigthCarousel,
                                             views: contenVM.arrayRovers)
                        }
                        Button(action: {
                            print("\(calculateSol.filterRover)")
                        }) {
                            Text("PUSH")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .offset(y: -200)
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
            CardRoverSettings(isSetting: $isSetting,
                              rover: rover,
                              height: height)
                .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: !isSetting ? UIScreen.main.bounds.width / 2 : -UIScreen.main.bounds.width  / 2)
        .animation(.linear(duration: 1), value: isSetting)
    }
    
}



#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
