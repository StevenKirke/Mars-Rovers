//
//  CardRoverSettings.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI

struct CardRoverSettings: View {
    
    @Binding var isSetting: Bool
    var rover: Rover
    var height: CGFloat
    
    var body: some View {
        NavigationLink(destination: EmptyView()) {
            GeometryReader { _ in
                VStack(spacing: 10) {
                    Button(action: {}) {
                        HStack(spacing: 11) {
                            Text("Show photos")
                                .customFont(size: 16)
                                .fontWeight(.regular)
                            Image(systemName: "chevron.forward")
                                .font(.system(size: 16, weight: .regular))
                        }
                    }
                    HStack(spacing: 25)  {
                        Button(action: {
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.isSetting.toggle()
                                }
                            }
                        }) {
                            Image.gear
                                .iconSize(size: 30)
                                .rotationEffect(Angle(degrees: isSetting ? -90 : 0))
                        }
                        Spacer()
                            .foregroundColor(.white)
                    }
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.b_555555)
                        .frame(height: 2)
                    SettingRover(isSetting: $isSetting, cameras: rover.cameras)
                }
                .padding(.horizontal, 26)
                .padding(.top, 15)
                .foregroundColor(.white)
            }
            .frame(height: height)
            .background(
                VStack(spacing: 0) {
                    Image.starfield
                        .resizable()
                    Image.starfield
                        .resizable()
                        .rotationEffect(.degrees(180))
                }
                    .mask(RoundedCornersShape(corners: [.topLeft, .topRight], radius: 13)
                        .fill(Color.white))
            )
        }
    }
}


struct SettingRover: View, WriteRover {
    
    @EnvironmentObject var calculateSol: CalculateSolModel
    
    @State var camera: String = ""
    @Binding var isSetting: Bool
    
    var title: String {
        return "Sol: " + String(calculateSol.filterRover.sol)
    }
    
    var currentSol: String {
        removeZeros(number: calculateSol.breakSol)
    }
    
    var cameras: [Camera]
    
    
    func readingDataRover() {
        
    }
    
    func saveDataRover(_ index: Int) {
        calculateSol.filterRover.camera = camera
        calculateSol.filterRover.tempSol = calculateSol.saveCurrentSol(maxSol: calculateSol.filterRover.sol)
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack(spacing: 25) {
                    Image.sun
                        .iconSize(size: 30)
                        .rotationEffect(Angle(degrees: isSetting ? 90 : 0))
                    Text(title)
                        .customFont(size: 16)
                        .fontWeight(.bold)
                    Spacer()
                    Text(currentSol)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 12)
                        .frame(width: 120, height: 27)
                        .background(Color.b_555555)
                        .cornerRadius(7)
                    
                }
                showWheel()
                showCameras()
                    .padding(.bottom, 50)
            }
        }
        .onAppear() {
            print("onAppear - \(calculateSol.filterRover)")
        }
    }
    
    @ViewBuilder
    private func showWheel() -> some View {
        if isSetting {
            HStack(spacing: 10) {
                ForEach(0..<calculateSol.countPicker, id: \.self) { index in
                    SelectWheel(selector: $calculateSol.breakSol[index], iteration: index)
                }
            }
            .onDisappear() {
                saveDataRover(0)
            }
        }
    }
    
    @ViewBuilder
    private func showCameras() -> some View {
        SelectCamera(cameras: cameras, camera: $camera)
    }
    
    private func removeZeros(number: [Int]) -> String {
        var tempString = ""
        _ = number.map {
            tempString = tempString + "\($0)"
        }
        let trim: String? = tempString.replacingOccurrences(of: "^0+", with: "", options: .regularExpression)
        
        guard let tempTrim = trim else {
            return "0"
        }
        if tempTrim == "" {
            return "0"
        }
        return tempTrim
    }
}


struct SelectWheel: View {
    
    @State  var maxThreshold: Int = 9
    @Binding var selector: Int
    var iteration: Int = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $selector) {
                ForEach(0...maxThreshold, id: \.self) { elem in
                    Text("\(elem)")
                        .foregroundColor(.white)
                }
            }
            .pickerStyle(.wheel)
        }
        .onAppear() {
            self.maxThreshold = iteration == 0 ? selector : 9
        }
        
    }
}

struct SelectCamera: View {
    
    var cameras: [Camera]
    @State var indexCamera: Int = 0
    @Binding var camera: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            HStack(alignment: .center, spacing: 25) {
                Image.camera
                    .iconSize(size: 30)
                Text("Camera: ")
                    .customFont(size: 16)
                    .fontWeight(.bold)
            }
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(cameras.indices, id: \.self) { item in
                        ButtonCamera(title: cameras[item].name, index: item, currentIndex: $indexCamera, camera: $camera)
                    }
                }
            }
        }
        .background(
            Image.starfield
                .resizable()
                .rotationEffect(Angle(degrees: 90))
        )
    }
}

struct ButtonCamera: View {
    
    var title: String
    var index: Int = 0
    
    @Binding var currentIndex: Int
    @Binding var camera: String
    
    var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                withAnimation {
                    self.currentIndex = index
                    self.camera = title
                }
            }
        }) {
            Text(title)
                .customFont(size: 16)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
        }
        .frame(width: 120, height: 27)
        .background(index == currentIndex ? Color.b_555555_30 : Color.b_555555)
        .cornerRadius(7)
    }
}



#if DEBUG
struct CardRoverSettings_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(globalModel: GlobalModel())
    }
}
#endif


/*
 NavigationLink(destination: PhotosView(), isActive: $isGallery) {}
 Button(action: {
 DispatchQueue.main.async {
 withAnimation {
 self.isGallery = true
 }
 }
 }) {
 HStack(spacing: 11) {
 Text("Show photos")
 .customFont(size: 16)
 .fontWeight(.regular)
 Image(systemName: "chevron.forward")
 .font(.system(size: 16, weight: .regular))
 }
 }
 }
 */
