//
//  CardRoverSettings.swift
//  MarsRovers
//
//  Created by Steven Kirke on 14.04.2023.
//

import SwiftUI

struct CardRoverSettings: View {
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    @Binding var isSetting: Bool
    @Binding var filter: Filter
    
    
    @State var labelFilter: String = ""
    
    
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
                    
                    ZStack {
                        Text(labelFilter)
                            .customFont(size: 16)
                            .fontWeight(.bold)
                        HStack(spacing: 25)  {
                            Button(action: {
                                var transaction = Transaction(animation: .easeInOut(duration: 1))
                                transaction.disablesAnimations = true
                                withTransaction(transaction) {
                                    print("\(filter.camera) \(filter.sol)")
                                    if filter.camera != "" && filter.sol != -1 {
                                        print("Correct")
                                        self.isSetting.toggle()
                                       
//                                        if filter.camera == "" && filter.sol >= 0 {
//                                            self.labelFilter = "Select camera"
//                                        } else if filter.sol == -1 && filter.camera != "" {
//                                            self.labelFilter = "Select Sol"
//                                        } else if filter.camera == "" && filter.sol == -1 {
//                                            self.labelFilter = "Select camera and Sol"
//                                        } else {
//                                            self.labelFilter = ""
//                                        }
                                    } else {
                                        print("Select camera and Sol")
                                       
                                        
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
                    }
                    RoundedRectangle(cornerRadius: 1)
                        .fill(Color.b_555555)
                        .frame(height: 2)
                    SettingRover(title: "Sol \(rover.maxSol)",
                                 maxSol: rover.maxSol,
                                 image: .sun, filter: $filter)
                    SelectCamera(title: "Cameras",
                                 data: "", image: .camera,
                                 cameras: rover.cameras, filter: $filter)
                }
                .padding(.horizontal, 26)
                .padding(.top, 15)
                .foregroundColor(.white)
            }
        }
        .frame(height: height * 1.6)
    }
}




struct SettingRover: View {
    
    @ObservedObject var SettingVM: CardRoverSettingsVeiwModel = CardRoverSettingsVeiwModel()
    
    var title: String
    var maxSol: Int
    var image: Image
    
    @State var isActiveParam: Bool = false
    
    @Binding var filter: Filter
    
    
    var body: some View {
        VStack() {
            HStack(spacing: 25) {
                image
                    .iconSize(size: 30)
                Text(title)
                    .customFont(size: 16)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    DispatchQueue.main.async {
                        self.isActiveParam.toggle()
                        if isActiveParam {
                            self.SettingVM.countNumbers(maxSol)
                            self.SettingVM.breakNumberSol(maxSol)
                        } else {
                            filter.sol = self.answerCurrentSol(arraySol: SettingVM.breakSol, countSol: maxSol)
                        }
                    }
                    //                    DispatchQueue.main.async {
                    //                        self.SettingVM.countNumbers(maxSol)
                    //                        self.SettingVM.breakNumberSol(maxSol)
                    //                    }
                }) {
                    Text("\(String(filter.sol))")
                        .customFont(size: 16)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing, 12)
                }
                .frame(width: 120, height: 27)
                .background(Color.b_555555)
                .cornerRadius(7)
            }
            VStack(spacing: 0) {
                showWheel()
            }
            .onAppear() {
                self.filter.sol = -1
                self.filter.camera = ""
            }
        }
    }
    
    @ViewBuilder
    func showWheel() -> some View {
        if isActiveParam == true {
            HStack(spacing: 10) {
                ForEach(0..<SettingVM.countForPicker, id: \.self) { index in
                    SelectWheel(selector: $SettingVM.breakSol[index],
                                iteration: index)
                }
            }
        } else {
            Text("1")
        }
    }
    
    
    func answerCurrentSol(arraySol: [Int], countSol: Int) -> Int {
        var myString = ""
        _ = arraySol.map{
            myString = myString + "\($0)"
        }
        var currentNumber = Int(myString)
        guard let currentSol = currentNumber else {
            return countSol
        }
        if currentSol > countSol {
            return countSol
        }
        print(countSol)
        print(currentSol)
        return currentSol
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
    var data: String
    var image: Image
    var cameras: [Camera]
    
    @Binding var filter: Filter
    
    @State var currentIndex: Int = -1
    
    var body: some View {
        HStack(alignment: .top, spacing: 25) {
            HStack(alignment: .center, spacing: 25) {
                image
                    .iconSize(size: 30)
                VStack(alignment: .leading, spacing: 0) {
                    Text(title)
                        .customFont(size: 16)
                        .fontWeight(.bold)
                    Text("Camera: \(filter.camera)")
                        .customFont(size: 10)
                        .foregroundColor(.w_FFFFFF_40)
                        .fontWeight(.regular)
                }
            }
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(cameras.indices, id: \.self) { item in
                        ButtonCamera(title: cameras[item].name, index: item, currentIndex: $currentIndex, filter: $filter)
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
    @Binding var filter: Filter
    
    var body: some View {
        Button(action: {
            self.currentIndex = index
            filter.camera = title
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
