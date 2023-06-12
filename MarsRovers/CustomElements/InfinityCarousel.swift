//
//  InfinityCarousel.swift
//  MarsRovers
//
//  Created by Steven Kirke on 10.04.2023.
//

import SwiftUI


struct InfinityCarousel: View {
    
    @GestureState private var dragState = DragState.inactive
    @State var carouselLocation: Int = 0
    @State var curentIndex: Int = 0
    
    @Binding var index: Int
    
    var width: CGFloat = 380
    var height: CGFloat = 300
    var widthMultiply: CGFloat = 250
    
    var precent: CGFloat {
        let precent: CGFloat = 80
        return (precent * height) / 100
    }
    
    var views: [ImagesRovers]
    
    var body: some View {
        let tempIndex = Binding {
            relativeLoc(views)
        } set: {
            self.curentIndex = $0
        }
        VStack {
            ZStack(alignment: .bottom) {
                ForEach(0..<views.count, id: \.self) { item in
                    BigCard(card: views[item].bigImage)
                        .frame(width: UIScreen.main.bounds.width - 52,
                               height: item == relativeLoc(views) ? height : precent)
                        .cornerRadius(10)
                        .shadow(radius: 3)
                        .opacity(self.getOpacity(item, views))
                        .offset(x: self.getOffset(item, views))
                        .offset(y: self.getOffsetY(item, views))
                        .zIndex(self.getZindex(item, views))
                        .animation(.interpolatingSpring(stiffness: 300.0, damping: 50.0, initialVelocity: 10.0), value: relativeLoc(views))
                }
            }
            .gesture(
                DragGesture()
                    .updating($dragState) { drag, state, transaction in
                        state = .dragging(translation: drag.translation)
                    }
                    .onEnded({
                        onDragEnded(drag: $0)
                        self.index = relativeLoc(views)
                    })
            )
            HStack(spacing: 16) {
                ForEach(0..<views.count, id: \.self) { item in
                    LittleIcon(currentIndex: tempIndex,
                               icon: views[item].littleImage,
                               index: item)
                }
            }
            .padding(.top, 0)
        }
    }
}


extension InfinityCarousel {
    
    private func relativeLoc(_ arr: [Any]) -> Int {
        ((arr.count * 10000) + carouselLocation) % arr.count
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let dragThreshold: CGFloat = 200
        if drag.predictedEndTranslation.width > dragThreshold || drag.translation.width > dragThreshold {
            carouselLocation =  carouselLocation - 1
        } else if (drag.predictedEndTranslation.width) < (-1 * dragThreshold) || (drag.translation.width) < (-1 * dragThreshold) {
            carouselLocation =  carouselLocation + 1
        }
    }
    
    private func getOpacity(_ i: Int, _ arr: [Any]) -> Double {
        let count = arr.count
        switch relativeLoc(arr) {
            case i:
                return 1
            case (i - 2)...(i + 2), ((i - 1) + count), ((i + 1) - count):
                return 0.2
            default:
                return 0
        }
    }
    
    private func getZindex(_ i: Int, _ arr: [Any]) -> Double {
        let count = arr.count
        switch relativeLoc(arr) {
            case i:
                return 2
            case (i - 2)...(i + 2), ((i - 1) + count), ((i + 1) - count):
                return 1
            default:
                return 0
        }
    }
    
    private func getOffsetY(_ i: Int, _ arr: [Any]) -> Double {
        let count = arr.count
        switch relativeLoc(arr) {
            case i:
                return 0
            case (i - 2)...(i + 2), ((i - 1) + count), ((i + 1) - count):
                return 25
            default:
                return 0
        }
    }
    
    func getOffset(_ i:Int, _ arr: [Any]) -> CGFloat {
        let relative = relativeLoc(arr)
        let count = arr.count
        
        if (i) == relative {
            return self.dragState.translation.width
        } else if (i) == relative + 1 || (relative == count - 1 && i == 0) {
            return self.dragState.translation.width + (widthMultiply + 20)
        } else if
            (i) == relative - 1
                ||
                (relative == 0 && (i) == count - 1) {
            return self.dragState.translation.width - (widthMultiply + 20)
        } else if
            (i) == relative + 2
                ||
                (relative == count - 1 && i == 1)
                ||
                (relative == count - 2 && i == 0) {
            return self.dragState.translation.width + (2 * (widthMultiply + 20))
        } else if
            (i) == relative - 2
                ||
                (relative == 1 && i == count - 1)
                ||
                (relative == 0 && i == count - 2) {
            return self.dragState.translation.width - ( 2 * (widthMultiply + 20))
        } else if
            (i) == relative + 3
                ||
                (relative == count - 1 && i == 2)
                ||
                (relative == count - 2 && i == 1)
                ||
                (relative == count - 3 && i == 0) {
            return self.dragState.translation.width + (3 * (widthMultiply + 20))
        } else if
            (i) == relative - 3
                ||
                (relative == 2 && i == count - 1)
                ||
                (relative == 1 && i == count - 2)
                ||
                (relative == 0 && i == count - 3) {
            return self.dragState.translation.width - (3 * (widthMultiply + 20))
        } else {
            return 10000
        }
    }
    
    enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
                case .inactive:
                    return .zero
                case .dragging(let translation):
                    return translation
            }
        }
        var isDragging: Bool {
            switch self {
                case .inactive:
                    return false
                case .dragging:
                    return true
            }
        }
    }
}

struct BigCard: View {
    
    var card: Image
    
    var body: some View {
        VStack(spacing: 0) {
            card
                .resizable()
                .scaledToFill()
                .frame(maxWidth: UIScreen.main.bounds.width - 30)
        }
    }
}

struct LittleIcon: View {
    
    @Binding var currentIndex: Int
    var icon: Image
    var index: Int = 0
    
    var body: some View {
        icon
            .resizable()
            .scaledToFit()
            .frame(height: 22)
            .foregroundColor(.black)
            .opacity(index == currentIndex ? 1: 0.3)
    }
}

#if DEBUG
struct InfinityNumber_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(globalModel: GlobalModel())
    }
}
#endif
