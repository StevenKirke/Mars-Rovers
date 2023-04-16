//
//  ContentView.swift.swift
//  MarsRovers
//
//  Created by Steven Kirke on 08.04.2023.
//

import SwiftUI





struct ContentView: View {
    
    @ObservedObject var contenVM: ContentVewModel = ContentVewModel()
    @State var isSetting: Bool = false
    
    var title: String {
        return isSetting ? "Settings" : contenVM.rovers.rovers[contenVM.currentIndex].name
    }
    
    var body: some View {
        VStack(spacing: 0) {
            answerView()
        }
        .edgesIgnoringSafeArea(.vertical)
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
                        CustomNavigationView(title: title,
                                             content: EmptyView())
                        ZStack(alignment: .topLeading) {
                            InfinityCarousel(index: $contenVM.currentIndex,
                                             height: heigthCarousel,
                                             views: contenVM.arrayRovers)
                        }
                        Spacer()
                    }
                    CardContent(filter: $contenVM.filter,
                                rover: contenVM.rovers.rovers[contenVM.currentIndex],
                                icon: contenVM.arrayRovers[contenVM.currentIndex].littleImage,
                                height: heightInfo)
                }
            }
        }
    }
}

struct CardContent: View {
    
    @State var isSetting: Bool = false
    @Binding var filter: Filter
    
    var rover: Rover
    var icon: Image
    var height: CGFloat
    
    
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            CardRoverDescription(rover: rover, icon: icon, height: height, filter: filter, isSetting: $isSetting)
                .frame(width: UIScreen.main.bounds.width)
            // CardRoverSettings(rover: rover, icon: icon, height: height, isSetting: $isSetting, filter: $filter)
            //  .frame(width: UIScreen.main.bounds.width)
        }
        .frame(width: UIScreen.main.bounds.width)
        // .offset(x: !isSetting ? UIScreen.main.bounds.width / 2 : -UIScreen.main.bounds.width  / 2)
    }
    
}



#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
