//
//  ContentView.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 1/27/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        ZStack{
            
            VStack {
                Rectangle()
                    .foregroundColor(Color.orange)
                    .frame(width: 1000, height: 300)
                    .clipShape(UnevenRoundedRectangle(bottomLeadingRadius: 50))
                    .mask(alphaMaskTop(width:1000, height:300))
                Spacer()
                Rectangle()
                    .foregroundColor(Color.orange)
                    .frame(width: 1000, height: 600)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 50))
                    .mask(alphaMaskBottom(width:1000, height:600))
            }
            
            .padding()
            .statusBar(hidden: true)
            .containerRelativeFrame([.horizontal, .vertical])
            //.ignoresSafeArea()
            
            // .mask(maskView())
            
            
            .background(Color.black)
          
   
            
            
            
            
        }
    }
        
}

@ViewBuilder func alphaMaskTop(width:CGFloat, height:CGFloat) -> some View {
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
                .offset(x: 100, y:-30)
                .overlay(
                    Text("9:42")
                        .font(Font.system(size: 90))
                        .colorInvert()
                )
       // }
        
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
