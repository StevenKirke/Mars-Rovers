//
//  SignalAnim.swift
//  MarsRovers
//
//  Created by Steven Kirke on 12.06.2023.
//

import SwiftUI


struct ArrowShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height/2.0))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        
        return path
    }
}




struct SignalAnim: View {
    
    private let arrowCount = 4
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @State var scale:CGFloat = 1.0
    @State var fade:Double = 1.0
    
    var body: some View {
        ZStack {
            Color(red: 29.0/255.0, green: 161.0/255.0, blue: 224.0/255.0).edgesIgnoringSafeArea(.all)
            HStack{
                ForEach(0..<self.arrowCount, id: \.self) { item in
                    ArrowShape()
                        .stroke(style: StrokeStyle(lineWidth: CGFloat(10),
                                                   lineCap: .round,
                                                   lineJoin: .round ))
                        .foregroundColor(Color.white)
                        .aspectRatio(CGSize(width: 28, height: 70), contentMode: .fit)
                        .frame(maxWidth: 20)
                        .animation(nil, value: false)
                        .opacity(self.fade)
                        .scaleEffect(self.scale)
                        .animation(anim(item), value: false)
                }
                .onReceive(self.timer) { _ in
                    self.scale = self.scale > 1 ?  1 : 1.2
                    self.fade = self.fade > 0.5 ? 0.5 : 1.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.scale = 1
                        self.fade = 0.0
                    }
                }
            }
        }
    }
    
    private func anim(_ delay: Int) -> Animation {
        .linear(duration: 0.5)
        .repeatCount(1, autoreverses: true)
        .delay(0.2 * Double(delay))
    }
}

#if DEBUG
struct SignalAnim_Previews: PreviewProvider {
    static var previews: some View {
        SignalAnim()
    }
}
#endif

