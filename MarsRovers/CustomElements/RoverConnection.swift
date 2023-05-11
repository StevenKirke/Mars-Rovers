//
//  RoverConnection.swift
//  MarsRovers
//
//  Created by Steven Kirke on 02.05.2023.
//

import SwiftUI


struct RoverConnection: View {
    
    @State var geoG: CGRect = .zero
    @State var roverG: CGRect = .zero
    @State var roverL: CGRect = .zero
    @State var areaTop: CGFloat = 0.0
    
    var sizeRover: CGFloat = 200
    var offsetX: CGFloat = 40
    var offsetY: CGFloat = -40
    
    @State var rotate: Double = 0.0
    
    @State var isAnin: Bool = false
    
    
    var body: some View {
        GeometryReader { geo in
            let geoG = geo.frame(in: .global)
            let geoL = geo.frame(in: .local)
            let saveArea = geo.safeAreaInsets.top
            ZStack {
                GeometryReader { roverGeo in
                    let roverG = roverGeo.frame(in: .global)
                    let roverL = roverGeo.frame(in: .local)
                    
                    Image.roverAnim
                        .resizable()
                        .scaledToFit()
                        .opacity(0.2)
                    
                        .onAppear() {
                            self.geoG = geoG
                            self.roverG = roverG
                            self.roverL = roverL
                            self.areaTop = saveArea
                            print("geoG \nMIN: \(geoG.minX):\(geoG.minY) \nCEN: \(geoG.midX):\(geoG.midY) \nMAX: \(geoG.maxX):\(geoG.maxY)")
                            
                            print("roverG \nMIN: \(roverG.minX):\(roverG.minY) \nCEN: \(roverG.midX):\(roverG.midY) \nMAX: \(roverG.maxX):\(roverG.maxY)")
                            print("roverL \nMIN: \(roverL.minX):\(roverL.minY) \nCEN: \(roverL.midX):\(roverL.midY) \nMAX: \(roverL.maxX):\(roverL.maxY)")
                            
                            DispatchQueue.main.async {
                                withAnimation(anim()) {
                                    self.rotate = 72
                                }
                            }
                        }
                }
                .frame(width: sizeRover, height: sizeRover)
                .border(.red).opacity(0.3)
                .offset(x: offsetX, y: offsetY)
                Aerial(isAnim: $isAnin, roverG: $roverL)
                    .frame(width: sizeRover / 3, height: sizeRover / 3)
                    .rotationEffect(Angle(degrees: rotate), anchor: .bottom)
                    .animationObserver(for: rotate, onComplete: {
                        self.isAnin = true
                    })
                .position(x: geoG.midX + offsetX + precent(14), y: geoG.midY - areaTop - precent(34) + offsetY)
                Slider(value: $rotate , in: 0...180)
            }
            
            
        }
    }
    
    private func precent(_ multiplay: CGFloat) -> CGFloat {
        sizeRover / 100 * multiplay
    }
    
    private func anim() -> Animation {
        return
            .easeInOut(duration: 3)
            .delay(3)
    }
    
}

struct Aerial: View {
    
    @Binding var isAnim: Bool
    @Binding var roverG: CGRect
    
    var body: some View {
        GeometryReader { geo in
            let geoA = geo.frame(in: .local)
            ZStack {
                Image.aerialAnim
                    .resizable()
                    .scaledToFit()
                    .opacity(0.1)
                ForEach(1..<4) { elem in
                    let multiplier = Double(elem) * 0.5
                    CircleAnimation(isAnim: $isAnim, delay: multiplier)
                }

                    .position(x: roverG.minX + (geoA.width / 2), y: roverG.minY)
            }
            .onAppear() {
                print("geoA \nMIN: \(geoA.minX):\(geoA.minY) \nCEN: \(geoA.midX):\(geoA.midY) \nMAX: \(geoA.maxX):\(geoA.maxY)")
            }
        }
        .border(.orange)
    }
}


struct CircleAnimation: View {
    
    @Binding var isAnim: Bool
    @State var radius: CGFloat = 150
    
    var delay: Double
    
    var body: some View {
        Circle()
            .stroke(Color.red)
            .opacity(isAnim ? 0 : 1)
            .frame(width: isAnim ? radius : 0, height: isAnim ? radius : 0)
            .animation(anim(delay), value: isAnim)
    }
    
    private func anim(_ delay: Double) -> Animation {
        return
            .easeInOut(duration: 3)
            .repeatForever(autoreverses: false)
            .delay(delay)
    }
}




struct RoverConnection_Previews: PreviewProvider {
    static var previews: some View {
        RoverConnection()
    }
}


public extension View {
    func animationObserver<Value: VectorArithmetic>(for value: Value,
                                                    onChange: ((Value) -> Void)? = nil,
                                                    onComplete: (() -> Void)? = nil) -> some View {
        self.modifier(AnimateObserver(for: value, onChange: onChange, onComplete: onComplete))
    }
}

struct AnimateObserver<Value: VectorArithmetic>: AnimatableModifier {
    
    private let observedValue: Value
    private let onChange: ((Value) -> Void)?
    private let onComplete: (() -> Void)?
    public var animatableData: Value {
        didSet {
            notifyProgress()
        }
    }
    
    public init(for observedValue: Value, onChange: ((Value) -> Void)?, onComplete: (() -> Void)?) {
        self.observedValue = observedValue
        self.onChange = onChange
        self.onComplete = onComplete
        animatableData = observedValue
    }
    
    public func body(content: Content) -> some View {
        content
    }
    
    private func notifyProgress() {
        DispatchQueue.main.async {
            onChange?(animatableData)
            if animatableData == observedValue {
                onComplete?()
            }
        }
    }
}
