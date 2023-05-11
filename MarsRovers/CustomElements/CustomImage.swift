//
//  CustomImage.swift
//  MarsRovers
//
//  Created by Steven Kirke on 27.04.2023.
//

import SwiftUI

struct CustomImage: View {
    
    let image: String
    
    @Binding var tempImage: Image?
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image)) { phase in
                switch phase {
                    case .empty:
                        ProgressView()
                            .tint(.white)
                    case .success(let tempImage):
                        showImage(image: tempImage)
                    case .failure(_):
                        Image(systemName: "photo")
                            .resizable()
                    @unknown default:
                        Image(systemName: "photo")
                            .resizable()
                }
            }
        }
    }
    
    private func showImage(image: Image) -> some View {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tempImage = image
        }
        return image
            .resizable()
    }
}
