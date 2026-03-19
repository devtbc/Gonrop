//
//  ContentView.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 1/27/25.
//

import SwiftUI
import Combine

struct ContentView: View {

    @State var viewModel = ViewModel()
    @State var tmpTimeRem = 42//934
    
    var body: some View {
        
        GeometryReader { geo in
        //place for geoperportens?
           let quarterHeight = geo.size.height*0.25
            ZStack{
                
                VStack {
                    
                   
                    Rectangle()
                        .foregroundColor(Color.orange)
                        .frame(width: geo.size.width, height: quarterHeight)
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
                } //End of Stack of background and masks
                .padding()
                .background(Color.black)
                .containerRelativeFrame([.horizontal])
#if os(iOS)
                .statusBar(hidden: true)
#endif
                
                
                //Content on background in the Zstack
                VStack{
                    HStack{
                        clockView(timer: viewModel.timer)
                        Spacer()
                        calView()
                    }
                    .offset(CGSize(width: geo.size.width/8, height: geo.size.height/16))
                    .safeAreaPadding(.trailing, geo.size.width/6)
                    Spacer()
                }
                    
                    //ideas for positing? btn view should not be dependnet on above/bellow
                VStack(){
                    Spacer()
                    Spacer()
                    
                    HStack(spacing: 50){
                        
                        GaugeDemo(progress: Double(0.69))
                            .frame(width: 200, height: 200)
                            .onReceive(viewModel.timer) { _ in
                                
                            }
                        VStack{
                            
                            timerView(timerVM: $viewModel.timerVM1)
                            
                            timerViewMarkedForDeath(timeRemaining: $tmpTimeRem)
                                .onReceive(viewModel.timer) { _ in
                                    if self.tmpTimeRem > 0 {
                                        tmpTimeRem -= 1
                                    }
                                }
                        }
                        
                        
                    }
                    
                    buttonView(timerVM: $viewModel.timerVM1)
                    Spacer()
                } //end of VStack
                .offset(CGSize(width: -geo.size.width*0.06, height: geo.size.height*0.1))
                
                
                
                
            } ///ZStack of overlaping background and content stacks
            ///currently at {V-back V-top V-Bottom}
        } //end of geo
    }//end of body
} //end of ContentView










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



//I think it's fun, this needing to work backwords and remember were your brain was
////TODO: make an alart ir confrim/reject buttons and specific area for them. Btm right?
//struct confirmRejectView: View {
//    var body: some View {
//        GNButton(<#T##label: String##String#>, <#T##action: () -> Void##() -> Void#>)
//    }
//}

struct buttonView: View {
    @Binding var timerVM: TimerViewModel
    
    var body: some View{
        Grid{
            
            GridRow{
                
            }.border(.red) // or
                .background(.red.opacity(0.2))
            GridRow{
                GNButton("Blu Task",  { timerVM.start() })
                GNButton("ST",  { timerVM.stop() })
            }
            GridRow{
                GNButton("Grn Task",  { })
                GNButton("AT",  { timerVM.addTime(240)})//TODO: takes another tick for this to go
            }
            
            GridRow{
                
            }
            
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



//tmp thingking out note.Should make fixed number of timerViews at first. Canextend in the future if needed.


//first try here is with duration only and only count down. Make another for up?
struct timerView: View {
    //Should have enither remaining OR a specific time until.
    //set time makes sense but when paused,
    @Binding var timerVM: TimerViewModel
    var endDate: Date?
    var cancellable: AnyCancellable?
//    init(){
//        if isRunning{
//            endDate = Date.now.addingTimeInterval (TimeInterval(timeRemaining))
//        }
//        endDate = nil
//        
//    }
    
    
    
    
    var body: some View{
        Text( timerVM.timeRemaining.hmsFormatted())
            .font(Font.system(size: 60))
            .monospaced()
            .foregroundColor(.orange)
    }
}



//This is a little conflated as a set timer vs a timer to a specific time.
//Only the status bar stuff should be pulled out
struct timerViewMarkedForDeath: View {
    @State var tmpbo = false
    @Binding var timeRemaining: Int

    var startTime = Date.now
    var duration: Double = 2
    
    
    
    var body: some View{

        var timerrrrange: ClosedRange<Date> = startTime...Date(timeInterval: (duration * 60), since: startTime)
        
        HStack{
            if (timeRemaining < 0 ) {
                scaleBarUp(showAni: $tmpbo)
                    .onChange(of: timeRemaining){tmpbo.toggle()}
                    .scaleEffect(0.6, anchor: .center)
            }
            else {
                scaleBarDown(showAni: $tmpbo)
                    .onChange(of: timeRemaining){tmpbo.toggle()}
                    .scaleEffect(0.6, anchor: .center)
            }
            //Text(timeRemaining.hmsFormatted()) //Text(event.startDate, style: .timer)
            Text(
                timeRemaining.hmsFormatted()//!Using this is wrong. Ticks happen every.5 second so this goes twice as fast
                //timerInterval: timerrrrange,
                //countsDown: false
                
                //timerInterval: startTime...Date(timeInterval: (duration * 60), since: startTime),
                //pauseTime: Date(timeInterval: (1 * 60), since: startTime),
                
            )
                .font(Font.system(size: 60))
                .monospaced()
                .foregroundColor(.orange)
            
        }
    }
}

struct clockView: View {
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    @State var notQuiteNow: Date = Date.now
    var body: some View{
        
        //Text(Date.now, style: .time)
        Text(notQuiteNow, format: .dateTime.hour(.twoDigits(amPM: .omitted)).minute().second())
            .font(Font.system(size: 90))
            .colorInvert()
            .monospaced()
            .onReceive(timer) { timerTickDate in
                notQuiteNow = timerTickDate
            }
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
                .foregroundColor(.white)
                .frame(width: width, height: height)
            Rectangle()
                .foregroundColor(.black)
                .frame(width: width, height: height*3/4)
                .clipShape(.rect(cornerRadius: 30))
                .offset(x: width/10, y:height/30)
            
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
