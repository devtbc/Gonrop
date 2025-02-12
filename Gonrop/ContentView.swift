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

@ViewBuilder func calView() -> some View {

    
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
        
        
//        EachWeekDay.allCases.forEach { day in
//            Rectangle()
//                .frame(width: 50, height: 100, alignment: .bottom)
//                .foregroundColor(Color.green)
//                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
//                .overlay(Text(day.rawValue))
//            
//        }
       
        
//        Rectangle()
//                        .frame(width: 50, height: 100, alignment: .bottom)
//                        .foregroundColor(Color.green)
//                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
//                        .overlay(Text(EachWeekDay.Mon.rawValue))
//        EachWeekDay.allCases.forEach { day in
//            print(day.rawValue)
//        }
        
//        ForEach(0..<7){num in
//            Rectangle()
//                .frame(width: 50, height: 100, alignment: .bottom)
//                .foregroundColor(Color.green)
//                .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, topTrailingRadius: 10))
//                .overlay(Text(EachWeekDay[num].rawValue))
//        }
    }
}

@ViewBuilder func buttonView() -> some View {
    Grid{
        
        GridRow{
            GNToggle({}).frame(width: 400)
                .padding(10)
                .foregroundStyle(.black)
                .background(Color.orange)
                .clipShape(.capsule)
            
            
        }
        
        GridRow {
            ForEach(0..<2) { _ in GNButton({}) }
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
    //.frame(width: 500, height: 100, alignment: .bottom)
    //.frame(alignment: .bottom)//
    
}

@ViewBuilder func clockView() -> some View {
    Text(Date.now, format: .dateTime.hour(.twoDigits(amPM: .omitted)).minute().second())
        .font(Font.system(size: 90))
        .colorInvert()
        .monospaced()
}

@ViewBuilder func alphaMaskTop(width:CGFloat, height:CGFloat) -> some View {
    //var body: some View {
        //white is to keep and black is toss
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
   // return body
}

@ViewBuilder func alphaMaskBottom(width:CGFloat, height:CGFloat) -> some View {
    //var body: some View {
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
   // return body
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
