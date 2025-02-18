//
//  ContentView.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 1/27/25.
//

import SwiftUI
//import GNButtons

struct ContentView: View {
    var body: some View {
        
        
        
        ZStack{
            
            VStack {
                
                Rectangle()
                    .foregroundColor(Color.orange)
                    .frame(width: 1200, height: 300)
                    .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 50))
                    .mask(alphaMaskTop(width:1200, height:300))
                Spacer()
                Rectangle()
                    .foregroundColor(Color.orange)
                    .frame(width: 1200, height: 650)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 50))
                    .mask(alphaMaskBottom(width:1200, height:650))
            }
            
            .padding()
            #if os(iOS)
            .statusBar(hidden: true)
            #endif
            .containerRelativeFrame([.horizontal, .vertical])

            
            
            .background(Color.black)
          
   
            
            
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    clockView()
                    Spacer()
                    calView()
                }
                
                Spacer(minLength: 220)

                
                buttonView()
                Spacer()
              
                
            }//end of HStack
            .frame(alignment: .bottom)//
            
        }
    }
        
}










enum EachWeekDay: String, CaseIterable{
    case Sun
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    
}


struct SometestView: View {
    var body: some View {
        
        ForEach(EachWeekDay.allCases, id: \.rawValue) { item in
            Rectangle()
                            .frame(width: 50, height: 100, alignment: .bottom)
                            .foregroundColor(Color.green)
                            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
                            .overlay(Text(item.rawValue))
        }
    }
}
func todayString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE"
    let dayOfTheWeekString = dateFormatter.string(from: Date())
    return dayOfTheWeekString
}

struct calView: View {
    
    var body: some View{
        HStack{
            
            
            ForEach(EachWeekDay.allCases, id: \.rawValue) { item in
                
                if item.rawValue == todayString(){
                    Rectangle()
                        .frame(width: 50, height: 120, alignment: .bottom)
                        .foregroundColor(Color.green)
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
                        .overlay(alignment: .top, content: {Text(item.rawValue).padding(.top, 5)})
                }
                else{
                    Rectangle()
                        .frame(width: 50, height: 100, alignment: .bottom)
                        .foregroundColor(Color.green)
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
                        .overlay(alignment: .top, content: {Text(item.rawValue).padding(.top, 5)})
                    // .overlay(Text(item.rawValue))
                }
            }
            
            
         
        }
    }
}

struct buttonView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var tmpTimeRem = 214
    var body: some View{
        Grid{
            
            GridRow{
                GNToggle("Beta Toggle", {}).frame(width: 300)
                    .padding(10)
                    .foregroundStyle(.black)
                    .background(Color.orange)
                    .clipShape(.capsule)
                //Spacer()
                timerView(timeRemaining: $tmpTimeRem).onReceive(timer){_ in
                    $tmpTimeRem.wrappedValue -= 1
                }//
            }
            GridRow{
                Spacer()
                GNButton("Blu Task",  { })
            }
            GridRow{
                Spacer()
                GNButton("Grn Task",  { })
            }
//            GridRow{
//                Spacer()
//                GNButton("Yel Finished",  { })
//            }
            
            GridRow {
                ForEach(0..<2) { num in GNButton("This is \(num) Button", {}) }
            }
            //.gridColumnAlignment(.leading)
            .padding(.vertical, 10)
            
            GridRow{

            }
            
//            GridRow{
//                Button(action: {}) {
//                    Text("Hello, Button!")
//                        .font(Font.system(size: 40))
//                }.frame(width: 400)
//                    .padding(10)
//                    .foregroundStyle(.black)
//                    .background(Color.orange)
//                    .clipShape(.capsule)
//            }
//                .padding(.vertical, 10)
            
        } //end of grid
        
    
    }
    
}

extension Int {
    func hmsFormatted() -> String {
        let hours = self / 3600
        let minutes = (self % 3600) / 60
        let seconds = (self % 3600) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct timerView: View {
    
    @Binding var timeRemaining: Int
//    public func goDown() -> Void{
//        $timeRemaining -= 1
//    }
    
    var body: some View{

        
        Text(timeRemaining.hmsFormatted())

            .font(Font.system(size: 60))
            .monospaced()
            .foregroundColor(.orange)
            
            
    }
}

struct clockView: View {
    var body: some View{
        Text(Date.now, format: .dateTime.hour(.twoDigits(amPM: .omitted)).minute().second())
            .font(Font.system(size: 90))
            .colorInvert()
            .monospaced()
    }
}

struct alphaMaskTop: View {
    let width:CGFloat, height:CGFloat
    //white is to keep and black is toss
    var body: some View{
        VStack(spacing: -height ){
            Rectangle()
                .foregroundColor(.white)
                .frame(width: width, height: height)
            
            Rectangle()
                .foregroundColor(.black)
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: 30))
                .offset(x: 100, y:-30)
            
            
            
        }
        .compositingGroup()
        .luminanceToAlpha()
    }
}

struct alphaMaskBottom :View {
    let width:CGFloat, height:CGFloat
    var body: some View {
        //white is to keep and black is toss
        VStack(spacing: -height ){
            Rectangle()
            // .fill()
                .foregroundColor(.white)
                .frame(width: width, height: height)
            //                .mask(alignment: .topLeading){
            //                    UnevenRoundedRectangle(topLeadingRadius: 50)
            //                }
            Rectangle()
            // .fill()
                .foregroundColor(.black)
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: 30))
                .offset(x: 100, y:30)
            // }
            
        }
        .compositingGroup()
        .luminanceToAlpha()
    }
}


struct maskView: View {
    var body: some View {
        //white is to keep and black is toss
        VStack(spacing: -200 ){
            Rectangle()
                .fill()
                .foregroundColor(.white)
                .frame(width: nil, height: 300)
//                .mask(alignment: .topLeading){
//                    UnevenRoundedRectangle(topLeadingRadius: 50)
//                }
            Rectangle()
                .fill()
                .foregroundColor(.black)
                .frame(width: nil, height: 200)
                .clipShape(.rect(cornerRadius: 30))
                .offset(x: 50, y:30)
        }
        .compositingGroup()
        .luminanceToAlpha()
    }
}

#Preview {
    ContentView()
}
