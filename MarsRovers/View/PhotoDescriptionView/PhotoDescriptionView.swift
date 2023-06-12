//
//  PhotoDescriptionView.swift
//  MarsRovers
//
//  Created by Steven Kirke on 30.04.2023.
//

import SwiftUI

struct PhotoDescriptionView: View {
    
    @Environment(\.presentationMode) var returnPhotos: Binding<PresentationMode>

    @GestureState var scale = 1.0
    var magnitification: some Gesture {
        MagnificationGesture()
            .updating($scale) { currentState, pastState, transactions in
                print(currentState)
                pastState = currentState
            }
    }
    
    var photo: Image
    
    var body: some View {
        GeometryReader { geo in
            let saveAreaTop = geo.safeAreaInsets.top
            VStack(spacing: 0) {
                CustomNavigationView(title: "", content: ButtonForNavigation(action: {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.returnPhotos.wrappedValue.dismiss()
                        }
                    }
                }))
                //GeometryReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        photo
                            .resizable()
                            .scaledToFill()
                            .scaleEffect(scale)
                    }
               // }
            }
            .onAppear() {
                print("saveAreaTop - \(saveAreaTop)")
            }
        }
        .gesture(magnitification)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
}



struct PhotoDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDescriptionView(photo: Image("Images/ImagesMock/FLB_734474133EDR_F1002208FHAZ00200M_.JPG"))
    }
}
