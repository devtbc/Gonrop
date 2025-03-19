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
        
        GeometryReader { geo in
            
            ZStack{
                
                VStack {
                    
                   
                    Rectangle()
                        .foregroundColor(Color.orange)
                        .frame(width: geo.size.width, height: geo.size.height*0.25)
                        .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 50))
                        .mask(alphaMaskTop(width:CGFloat(geo.size.width), height:CGFloat(geo.size.height)))
                    Spacer()
                    //Text("W:\(Int(geo.size.width)) --- H:\(Int(geo.size.height))")
                        .colorInvert()
                    Rectangle()
                        .foregroundColor(Color.orange)
                        .frame(width: geo.size.width, height: geo.size.height*3/4)//650
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 50))
                        .mask(alphaMaskBottom(width:CGFloat(geo.size.width), height:CGFloat(geo.size.height)))
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
    }//end of geo
        
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
    //timeRemaining = savedTimeRemaining -[currentTime timeIntervalSinceDate:savedDate];
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var tmpTimeRem = 934
    func stopTimer() {
            self.timer.upstream.connect().cancel()
        }
        
        func startTimer() {
            self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        }
    
    var body: some View{
        Grid{
            
            GridRow{
                Spacer()
                timerView(timeRemaining: $tmpTimeRem)
                    .onReceive(timer){_ in
                        $tmpTimeRem.wrappedValue -= 1
                        }
            }
            GridRow{
                GNButton("Blu Task",  { })
                GNButton("ST",  { startTimer()})
            }
            GridRow{
                GNButton("Grn Task",  { })
                GNButton("AT",  { stopTimer(); tmpTimeRem += 240})
            }
//            GridRow{
//                Spacer()
//                GNButton("Yel Finished",  { })
//            }
            
//            GridRow {
//                ForEach(0..<2) { num in GNButton("This is \(num) Button", {}) }
//            }
//            //.gridColumnAlignment(.leading)
//            .padding(.vertical, 10)
            
            GridRow{

            }
            
        }.onAppear() {
            // no need for UI updates at startup
            self.stopTimer()
        } //end of grid
        
    
    }
    
}

extension Int {
    func hmsFormatted() -> String {
        //This is going to be abs()
        
        
        
        let hours = abs(self) / 3600
        let minutes = (abs(self) % 3600) / 60
        let seconds = (abs(self) % 3600) % 60//show the abs value but - in front
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

struct timerView: View {
    @State var tmpbo = false
    @Binding var timeRemaining: Int

    var body: some View{

        HStack{
            if (timeRemaining < 0 ) {
                scaleBarUp(showAni: $tmpbo)
                    .onChange(of: timeRemaining){tmpbo.toggle()}
                    .scaleEffect(0.6, anchor: .center)
            }
            else {
                scaleBar(showAni: $tmpbo)
                    .onChange(of: timeRemaining){tmpbo.toggle()}
                    .scaleEffect(0.6, anchor: .center)
            }
            Text(timeRemaining.hmsFormatted())
                .font(Font.system(size: 60))
                .monospaced()
                .foregroundColor(.orange)
            
        }
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
                .frame(width: width, height: height/4)
            
            Rectangle()
                .foregroundColor(.black)
                .frame(width: width, height: height)
                .clipShape(.rect(cornerRadius: 30))
                .offset(x: width/10, y:-height/30)
            
            
            
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
                .frame(width: width, height: height*3/4)
                .clipShape(.rect(cornerRadius: 30))
                .offset(x: width/10, y:height/30)
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
