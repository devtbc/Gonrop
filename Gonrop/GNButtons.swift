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
            .font(  .system( size: 28)
                .weight(.semibold)
                    .monospaced()
                    )
            .frame(width: 400)
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



//#Preview {
//    GNButton({})
//}
