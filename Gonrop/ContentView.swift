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
                    .frame(width: 1200, height: 600)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 50))
                    .mask(alphaMaskBottom(width:1200, height:600))
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
                
                Spacer(minLength: 320)

                
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
    var body: some View{
        Grid{
            
            GridRow{
                GNToggle("Unfinshed Toggle!", {}).frame(width: 400)
                    .padding(10)
                    .foregroundStyle(.black)
                    .background(Color.orange)
                    .clipShape(.capsule)
                
                timerView()//.onReceive(<#T##publisher: Publisher##Publisher#>, perform: <#T##(Publisher.Output) -> Void#>)
                //.onReceive(timer){$timeRemaining -= 1}
                //.onReceive(timer)
                //                .onReceive(timer){
                //                    body
                //                }
            }
            
            GridRow {
                ForEach(0..<2) { num in GNButton("This is \(num) Button!", {}) }
            }
            .gridColumnAlignment(.leading)
            .padding(.vertical, 10)
            
            GridRow{
                
                //            Button(action: {}) {
                //                Text("Hello, Bttn!")
                //                    .font(Font.system(size: 90))
                //            }
                //            .padding(10)
                //            .foregroundStyle(.black)
                //            .background(Color.orange)
                //            .clipShape(.capsule)
            }
            
            GridRow{
                Button(action: {}) {
                    Text("Hello, Button!")
                        .font(Font.system(size: 40))
                }.frame(width: 400)
                    .padding(10)
                    .foregroundStyle(.black)
                    .background(Color.orange)
                    .clipShape(.capsule)
            }.gridColumnAlignment(.leading)
                .padding(.vertical, 10)
            
        }  //end of grid
        
    }
}

struct timerView: View {
    
    var timeRemaining = 240
//    public func goDown() -> Void{
//        $timeRemaining -= 1
//    }
    
    var body: some View{
        //Date.init(timeIntervalSinceNow: 240)
        
        // public func hmsFrom() -> (Int, Int, Int) {
        //    return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
        
        Text("\((timeRemaining % 3600) / 60): \((timeRemaining % 3600) % 60)")
        
        //    Text(timeRemaining.formatted(Date.FormatStyle()
        //        .day(.omitted)
        //        .month(.omitted)
        //        .year(.omitted)
        //        .hour(.twoDigits(amPM: .omitted)).second()
        //    ))
            .font(Font.system(size: 60))
        // .colorInvert() format: .dateTime.hour(.twoDigits(amPM: .omitted)).minute().second()
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
