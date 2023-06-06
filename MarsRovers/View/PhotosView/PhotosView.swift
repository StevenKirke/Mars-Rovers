//
//  PhotosView.swift
//  MarsRovers
//
//  Created by Steven Kirke on 26.04.2023.
//

import SwiftUI

struct PhotosView: View {
    
    @Environment(\.presentationMode) var returnSettings: Binding<PresentationMode>
    @EnvironmentObject var calculateSol: CalculateSolModel
    
    @ObservedObject var PhotosVM: PhotosViewModel = PhotosViewModel()
    
    var name: String {
        calculateSol.filterRover.roverName
    }
    
    var body: some View {
        GeometryReader { geo in
            let saveAreaTop = geo.safeAreaInsets.top
            NavigationView {
                ZStack(alignment: .bottom) {
                    Color.black.opacity(0.25)
                    VStack(spacing: 0) {
                        CustomNavigationView(title: name, height: saveAreaTop,
                                             content: ButtonForNavigation(action: {
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.returnSettings.wrappedValue.dismiss()
                                }
                            }
                        }))
                        VStack(spacing: 0) {
                            ScrollView(.vertical, showsIndicators: false) {
                                let currentWidth = UIScreen.main.bounds.width - 22
                                let size: CGSize = .init(width: currentWidth, height: calcHeight(width: currentWidth))
                                ForEach(PhotosVM.photos.photos.indices, id: \.self) { index in
                                    let currentCard = PhotosVM.photos.photos[index].imgSrc
                                    CardPhoto(image: currentCard, size: size)
                                }
                            }
                            .mask(RoundedRectangle(cornerRadius: 13))
                            .padding(.top, -saveAreaTop + 10)
                            .padding(.bottom, 10)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .onAppear() {
                    PhotosVM.getPhoto(rover: calculateSol.filterRover)
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
    
    private func calcHeight(width: CGFloat) -> CGFloat {
        let ratio: Float = 396 / 300
        let newHeight = Float(width) / ratio
        return CGFloat(newHeight)
    }
}


struct CardPhoto: View {
    
    @State var isPhoto: Bool = false
    @State var currentImage: Image? = nil
    var image: String
    var size: CGSize
    
    var body: some View {
        ZStack(alignment: .trailing) {
            CustomImage(image: image, tempImage: $currentImage)
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .mask(RoundedRectangle(cornerRadius: 13))
            .background(
                RoundedRectangle(cornerRadius: 13)
                    .fill(Color.black)
                    .shadow(color: .b_555555,radius: 4, y: 4)
            )
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            VStack(spacing: 0) {
                Spacer()
                ButtonInfo(isPhoto: $isPhoto, image: answerImage(image: currentImage), action: {
                    self.isPhoto.toggle()
                })
            }
            .padding(.trailing, 10)
            .padding(.vertical, 10)
        }
    }
    
    
    func answerImage(image: Image?) -> Image {
        guard let tempImage = image else {
            return Image(systemName: "square.and.arrow.up.on.square")
        }
        return tempImage
    }
}

struct ButtonInfo: View {
    
    @Binding var isPhoto: Bool
    var image: Image
    var action: () -> Void
    
    var body: some View {
        NavigationLink(destination: PhotoDescriptionView(photo: image), isActive: $isPhoto) {
            Button(action: action) {
                Image(systemName: "plus.magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 10)
                    .foregroundColor(Color.white)
                    .background(
                        RoundedRectangle(cornerRadius: 7)
                            .fill(Color.b_555555).opacity(0.4)
                    )
            }
        }
    }
}


#if DEBUG
struct PhotosView_Previews: PreviewProvider {
    
    static var previews: some View {
        //ContentView()
        PhotosView().environmentObject(CalculateSolModel())
    }
}
#endif


