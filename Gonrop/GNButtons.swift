//
//  GNButtons.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 2/9/25.
//

import SwiftUI

func GNButton(_ label: String, _ action: @escaping() -> Void) -> some View {
    return Button(label) { action()
    }
    
    .buttonStyle(GNButtonStyle())
//.frame(width: 400)
//    .padding(10)
//    .foregroundStyle(.black)
//    .background(Color.orange)
//    .clipShape(.capsule)
    
//    .padding(.horizontal, 30)
//    //.padding(20)
//    .foregroundStyle(.black)
//    .background(Color.orange)
//    .clipShape(.capsule)
}



//struct GNToggle(_ label: String, _ action: @escaping() -> Void)): View {
//    var body: some View {
//        Text("Hello, World!")
//    }
//}

func GNToggle(_ label: String, _ action: @escaping() -> Void) -> some View {
    @State var toggleState = false


    var tmpBody: some View {
        Toggle(isOn: $toggleState) {
            Text(label)
                .font(  .system( size: 28)
                    .weight(.semibold)
                        .monospaced()
                        
                )
        }
        
    }

    return  tmpBody//GNButton(action)
       // Text("Unfinshed Toggle!")
        

}

struct GNButtonStyle: ButtonStyle{
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font( .system( size: 38)
                .weight(.semibold)
                .monospaced()
            )
            .frame(width: 300, alignment: .topLeading)
            .padding(10)
            .foregroundStyle(.black)
            .background(Color.orange)
            .clipShape(.capsule)
    }
}

//struct CustomToggleStyle: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        Button(action: {
//            configuration.isOn.toggle()
//        }) {
//            configuration.label
//                .padding()
//                .background(configuration.isOn ? Color.green : Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(8)
//        }
//    }
//}
struct toggleViewTests: View {
    
    var body: some View{
        
        let usedHeight:CGFloat = 70
        let corners = RectangleCornerRadii(topLeading:(usedHeight/2),bottomLeading: (usedHeight/2), bottomTrailing: (usedHeight/2), topTrailing: (usedHeight/2))
        
        let cornersLeft = RectangleCornerRadii(topLeading:(usedHeight/2),bottomLeading: (usedHeight/2), bottomTrailing: (0), topTrailing: (0))
        let cornersRight = RectangleCornerRadii(topLeading:(0),bottomLeading: (0), bottomTrailing: (usedHeight/2), topTrailing: (usedHeight/2))
        //
        VStack{
            
            //whole button
            //or 27:70
            UnevenRoundedRectangle(cornerRadii: corners, style: .continuous)
                .frame(width: usedHeight*4, height:usedHeight)
                .foregroundStyle(.orange)
            //  .background(Color.orange)
            //            .clipShape(.capsule)
            
            
            //block long button
            HStack{
                Rectangle()
                    .frame(width: usedHeight/3, height:usedHeight)
                    .foregroundStyle(.orange)
                    .padding(.horizontal, usedHeight/3)
                UnevenRoundedRectangle(cornerRadii: cornersRight, style: .continuous)
                    .frame(width: usedHeight*3, height:usedHeight)
                    .foregroundStyle(.orange)
            }
            
            //whole split button
            HStack{
                UnevenRoundedRectangle(cornerRadii: cornersLeft, style: .continuous)
                    .frame(width: usedHeight*1, height:usedHeight)
                    .foregroundStyle(.orange)
                UnevenRoundedRectangle(cornerRadii: cornersRight, style: .continuous)
                    .frame(width: usedHeight*3, height:usedHeight)
                    .foregroundStyle(.orange)
            }
            
            //Short button
            HStack{
                UnevenRoundedRectangle(cornerRadii: cornersLeft, style: .continuous)
                    .frame(width: usedHeight*1, height:usedHeight)
                    .foregroundStyle(.orange)
                UnevenRoundedRectangle(cornerRadii: cornersRight, style: .continuous)
                    .frame(width: usedHeight*3, height:usedHeight)
                    .foregroundStyle(.orange)
                    .hidden()
            }
            
        }
        
    }
}

struct scaleBar: View {
    //TODO: make it scaleup or down aka scaleDirection
    enum Direction{
        case up, down
    }
    @State private var scaleDirection = Direction.down
    
    @Binding var showAni: Bool
    //mayve make it observable and then it will animate on apper
   // var size: CGFloat {showAni ? 0.0 : 1.0}
    
    @State var size: CGFloat = 1.0

    
    
    
    var body: some View{
        
//        switch scaleDirection {
//        case .up:
//            size = 1.0
//        case .down:
//            size = 0.0
//        default:
//            {}
//        }
    
        
        Rectangle()
            .frame(width: 25, height: 100)
            .foregroundStyle(.orange)
            .scaleEffect(x: 1, y: size, anchor: .bottom)
            .onChange(of: showAni){
                withAnimation(.linear(duration: 0.9)){size = 0.00} completion: {
                    size = 1.0
                }
            }
    }
}

struct scaleBarUp: View {
    //This is a duplicate that should be a different state for scaleBar
    enum Direction{
        case up, down
    }
    @State private var scaleDirection = Direction.down
    
    @Binding var showAni: Bool
    //mayve make it observable and then it will animate on apper
   // var size: CGFloat {showAni ? 0.0 : 1.0}
    
    @State var size: CGFloat = 0.0
    
    
    
    var body: some View{
        
//        switch scaleDirection {
//        case .up:
//            size = 1.0
//        case .down:
//            size = 0.0
//        default:
//            {}
//        }
    
        
        Rectangle()
            .frame(width: 25, height: 100)
            .foregroundStyle(.orange)
            .scaleEffect(x: 1, y: size, anchor: .bottom)
            .onChange(of: showAni){
                withAnimation(.linear(duration: 0.9)){size = 1.00} completion: {
                    size = 0.0
                }
            }
    }
}


struct RadialGauge: View {
    var value: Double // 0.0 to 1.0
    var lineWidth: CGFloat = 20
    var backgroundColor: Color = Color(.systemGray5)
    var foregroundColor: Color = .blue
    
    private let startAngle: Angle = .degrees(135)
    private let endAngle: Angle = .degrees(405) // 135 + 270
    
    var body: some View {
        Canvas { context, size in
            let rect = CGRect(origin: .zero, size: size).insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
            let center = CGPoint(x: rect.midX, y: rect.midY)
            let radius = min(rect.width, rect.height) / 2
            
            // Background arc
            var backgroundPath = Path()
            backgroundPath.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: endAngle,
                clockwise: false
            )
            
            context.stroke(
                backgroundPath,
                with: .color(backgroundColor),
                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
            )
            
            // Foreground arc (value)
            let valueAngle = startAngle + .degrees(270 * value)
            var valuePath = Path()
            valuePath.addArc(
                center: center,
                radius: radius,
                startAngle: startAngle,
                endAngle: valueAngle,
                clockwise: false
            )
            
            context.stroke(
                valuePath,
                with: .color(foregroundColor),
                style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

// Usage example with animation
struct GaugeDemo: View {
    @State var progress: Double // 0.0 to 1.0//Double = 0.0
    //var : Int
    //@Binding var timeRemaining: Int
    var body: some View {
        VStack(spacing: 40) {
            RadialGauge(
                value: progress,
                lineWidth: 24,
                backgroundColor: Color(.systemGray4),
                foregroundColor: .orange
            )
           // .frame(width: 200, height: 200)
            .overlay {
                Text("\(Int(progress * 100))%")
                    .font(.system(size: 36, weight: .semibold, design: .rounded))
                    .contentTransition(.numericText())
                    .colorInvert()
                    .offset(y: 20) 
            }
            
            //Slider(value: $progress, in: 0...1)
                //.padding(.horizontal, 40)
        }
        .animation(.smooth, value: progress)
        
    }
}

#Preview {
    ContentView()
}
