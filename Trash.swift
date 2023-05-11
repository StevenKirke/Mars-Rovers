

 func colorChange(_ tag: Int) {
     print("Color tag: \(tag)")
 }
 
 
 struct SelectCamera: View {
     
     var title: String
     var data: String
     var image: Image
     var cameras: [Camera]
     
     @Binding var filter: Filter
     
     @State var currentIndex: Int = 0
     
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
 
 
 func convertToString(arraySol: [Int]) -> String {
     var myString = ""
     _ = arraySol.map {
         myString = myString + "\($0)"
     }
     return myString
 }
 
 
 func answerCurrentSol(arraySol: [Int], countSol: Int) -> Int {
     var myString = ""
     _ = arraySol.map{
         myString = myString + "\($0)"
     }
     let currentNumber = Int(myString)
     guard let currentSol = currentNumber else {
         return countSol
     }
     if currentSol > countSol {
         return countSol
     }
     return currentSol
 }
 



@ViewBuilder
func showWheel() -> some View {
    if isSetting == true {
        HStack(spacing: 10) {
            ForEach(0..<SettingVM.countForPicker, id: \.self) { index in
                SelectWheel(selector: $SettingVM.breakSol[index],
                            iteration: index)
            }
        }
        .onAppear() {
            self.SettingVM.countNumbers(maxSol)
            self.SettingVM.breakNumberSol(maxSol)
            self.currentSol = String(filter.sol)
            print("\(SettingVM.countForPicker)")
            print("\(SettingVM.breakSol)")
            print("FILTER SOL -> \(filter.sol)")
        }
        .onDisappear() {
            
            //filter.sol = self.answerCurrentSol(arraySol: SettingVM.breakSol, countSol: maxSol)
            print("FILTER SOL <- \(filter.sol)")
        }
    }
}
 
 VStack(spacing: 0) {
     //showWheel()
       //  .onChange(of: SettingVM.breakSol) { newValue in
         //    print("onChange <> \(filter.sol)")
             //currentSol = String(self.answerCurrentSol(arraySol: newValue, countSol: maxSol))
         }
 }
 .onAppear() {
     self.SettingVM.countNumbers(maxSol)
     self.SettingVM.breakNumberSol(maxSol)
 }

 VStack(alignment: .leading, spacing: 5) {
    Text("\(filter.roverName)")
        .customFont(size: 8)
        .fontWeight(.regular)
    Text("\(String(filter.sol))")
        .customFont(size: 8)
        .fontWeight(.regular)
    Text("\(filter.camera) \(String(isSetting))")
        .customFont(size: 8)
        .fontWeight(.regular)
}

var transaction = Transaction(animation: .easeInOut(duration: 1))
transaction.disablesAnimations = true
withTransaction(transaction) {

}
                    //Text("\(String(self.answerCurrentSol(arraySol: SettingVM.breakSol, countSol: maxSol)))")
                    // .customFont(size: 16)
                    // .fontWeight(.bold)
 
 // self.isActiveParam.toggle()
 /*
  self.isActiveParam .toggle()
  if isActiveParam {
  self.SettingVM.countNumbers(maxSol)
  self.SettingVM.breakNumberSol(maxSol)
  } else {
  // filter.sol = self.answerCurrentSol(arraySol: SettingVM.breakSol, countSol: maxSol)
  }


