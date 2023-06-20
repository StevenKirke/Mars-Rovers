//
//  CardRoverSettings.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI

struct CardRoverSettings: View {
    
    @EnvironmentObject var CalculateRoverSettingM: CalculateRoverSettingModel
    
    @Binding var isSetting: Bool
    
    var rover: Rover
    var height: CGFloat
    
    var body: some View {
        
        GeometryReader { proxy in
            VStack(spacing: 10) {
                HStack(spacing: 25) {
                    GearButton(rotate: 0) {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.isSetting = false
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        print(CalculateRoverSettingM.currentRover)
                    }) {
                        Text("Show photos")
                            .customFont(size: 16)
                            .fontWeight(.regular)
                    }
                    //                    NavigationLink(destination: PhotosView(globalModel: GlobalModel())) {
                    //                        HStack(spacing: 11) {
                    //                            Text("Show photos")
                    //                                .customFont(size: 16)
                    //                                .fontWeight(.regular)
                    //                            Image(systemName: "chevron.forward")
                    //                                .font(.system(size: 16, weight: .regular))
                    //                        }
                    //                    }
                }
                RoundedRectangle(cornerRadius: 1)
                    .fill(Color.b_555555)
                    .frame(height: 2)
                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        SettingRover(isSetting: $isSetting, cameras: rover.cameras)
                    }
                }
            }
            .padding(.horizontal, 26)
            .padding(.top, 15)
            .foregroundColor(.white)
        }
        .frame(width: UIScreen.main.bounds.width, height: height)
        .background(Image.starfield
            .resizable()
            .mask(
                RoundedCornersShape(corners: [.topLeft, .topRight], radius: 13)
                    .fill(Color.white))
        )
    }
}


struct SettingRover: View, WriteRover {
    
    @EnvironmentObject var roverSetting: CalculateRoverSettingModel
    
    @State var camera: String = "" {
        willSet {
            if self.camera == "" {
                self.camera = roverSetting.currentRover.camera
            } else {
                self.camera = newValue
            }
        }
    }
    @Binding var isSetting: Bool
    
    
    var title: String {
        "Sol: " + String(roverSetting.currentRover.sol)
    }
    
    var cameras: [Camera] = []
    
    func saveDataRover(_ index: Int) {
        roverSetting.currentRover.camera = camera
        roverSetting.currentRover.tempSol = roverSetting.saveCurrentSol(maxSol: roverSetting.currentRover.sol)
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack(spacing: 25) {
                    Image.sun
                        .iconSize(size: 30)
                    Text(title)
                        .customFont(size: 16)
                        .fontWeight(.bold)
                    Spacer()
                    Text(roverSetting.currentSol)
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
    }
    
    @ViewBuilder
    private func showWheel() -> some View {
        if isSetting {
            HStack(spacing: 10) {
                ForEach(0..<roverSetting.countPickers, id: \.self) { index in
                    SelectWheel(selector: $roverSetting.numberSolsInWheel[index], iteration: index)
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
                        ButtonCamera(title: cameras[item].name,
                                     index: item,
                                     currentIndex: $indexCamera, camera: $camera)
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



