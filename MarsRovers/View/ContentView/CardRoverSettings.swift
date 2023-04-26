//
//  CardRoverSettings.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI

struct CardRoverSettings: View {
    
    @EnvironmentObject var calculateSol: CalculateSolModel
    @Binding var isSetting: Bool
    
   // @State var labelFilter: String = ""
    
   // @State var currentCamera: String = ""
    
    var rover: Rover
    var height: CGFloat
    
    var body: some View {
        GeometryReader { _ in
            VStack(spacing: 10) {
                ZStack {
                    Text("")
                        .customFont(size: 16)
                        .fontWeight(.bold)
                    HStack(spacing: 25)  {
                        Button(action: {
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.isSetting.toggle()
                                }
                            }
                        }) {
                            HStack(spacing: 25) {
                                Image.gear
                                    .iconSize(size: 30)
                                    .rotationEffect(Angle(degrees: isSetting ? -90 : 0))
                            }
                        }
                        Spacer()
                            .foregroundColor(.white)
                    }
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
        .frame(height: height * 1.6)
        .background(
            VStack(spacing: 0) {
                Image.starfield
                    .resizable()
                Image.starfield
                    .resizable()
                    .rotationEffect(.degrees(180))
            }
                .mask(RoundedRectangle(cornerRadius: 13))
            
        )
    }
}


struct SettingRover: View {
    
    @ObservedObject var SettingVM: CardRoverSettingsVeiwModel = CardRoverSettingsVeiwModel()
    @EnvironmentObject var calculateSol: CalculateSolModel
    
    @Binding var isSetting: Bool
    
    var cameras: [Camera]
    
    @State var camera: String = ""
    
    var body: some View {
        VStack() {
            HStack(spacing: 25) {
                Image.sun
                    .iconSize(size: 30)
                VStack(alignment: .leading) {
                    Text("Sol: ")
                        .customFont(size: 16)
                        .fontWeight(.bold)
                    HStack(spacing: 0 ) {
                        Text("Current sol: ")
                            .customFont(size: 10)
                            .fontWeight(.regular)
                        showCurrentSol(size: 10, weight: .regular)
                     }
                }
                Spacer()
                showCurrentSol(size: 16, weight: .bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 12)
                    .frame(width: 120, height: 27)
                    .background(Color.b_555555)
                    .cornerRadius(7)
            }
            ScrollView(.vertical, showsIndicators: false) {
                showWheel()
                    .transaction { transaction in
                        transaction.animation = nil
                    }
                showCameras()
            }

        }
    }
    
    @ViewBuilder
    func showWheel() -> some View {
            HStack(spacing: 10) {
                ForEach(0..<calculateSol.countPicker, id: \.self) { index in
                    SelectWheel(selector: $calculateSol.breakSol[index], iteration: index)
                }
            }
    }
    
    @ViewBuilder
    func showCurrentSol(size: CGFloat, weight: Font.Weight) -> some View {
        HStack(spacing: 0) {
            ForEach(SettingVM.breakSol.indices, id: \.self) { elem in
                Text("\(SettingVM.breakSol[elem])")
                    .customFont(size: size)
                    .fontWeight(weight)
            }
        }
    }
    
    @ViewBuilder
    func showCameras() -> some View {
            SelectCamera(title: "filter.camera",
                         cameras: cameras,
                         camera: $camera)
    }
    
}


struct SelectWheel: View {
    
    @State  var maxThreshold: Int = 0
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
    
    var title: String
    var cameras: [Camera]
    
    @Binding var camera: String
    
    @State var indexCamera: Int = 0
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            HStack(alignment: .center, spacing: 25) {
                Image.camera
                    .iconSize(size: 30)
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .customFont(size: 16)
                        .fontWeight(.bold)
                    Text("Camera: \(camera)")
                        .customFont(size: 10)
                        .foregroundColor(.white)
                        .fontWeight(.regular)
                }
            }
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(cameras.indices, id: \.self) { item in
                        ButtonCamera(title: cameras[item].name, index: item, currentIndex: $indexCamera, camera: $camera)
                    }
                }
            }
            .padding(.top, 0)
        }
    }
}

struct ButtonCamera: View {
    
    var title: String
    var index: Int = 0
    
    @Binding var currentIndex: Int
    @Binding var camera: String
    
    var body: some View {
        Button(action: {
            //            DispatchQueue.main.async {
            //                withAnimation {
            //                    self.currentIndex = index
            //                    self.camera = title
            //                }
            //            }
            //var transaction = Transaction(animation: .easeInOut(duration: 1))
            //transaction.disablesAnimations = true
            //withTransaction(transaction) {
            self.currentIndex = index
            self.camera = title
            // }
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
        ContentView()
    }
}
#endif

