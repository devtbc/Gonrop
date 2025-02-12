//
//  GNButtons.swift
//  Gonrop
//
//  Created by Tyler Stiffler on 2/9/25.
//

import SwiftUI

func GNButton(_ action: @escaping() -> Void) -> some View {
    return Button(action: {}) {
        Text("This is__<>Button!")
            .font(  .system( size: 28)
                .weight(.semibold)
                    .monospaced()
                    
            )
        
           
    }
    
.frame(width: 400)
    .padding(10)
    .foregroundStyle(.black)
    .background(Color.orange)
    .clipShape(.capsule)
    
//    .padding(.horizontal, 30)
//    //.padding(20)
//    .foregroundStyle(.black)
//    .background(Color.orange)
//    .clipShape(.capsule)
}




func GNToggle(_ action: @escaping() -> Void) -> some View {
    @State var toggleState = false


    var tmpBody: some View {
        Toggle(isOn: $toggleState) {
            Text("Unfinshed Toggle!")
                .font(  .system( size: 28)
                    .weight(.semibold)
                        .monospaced()
                        
                )
        }
        
    }

    return  tmpBody//GNButton(action)
       // Text("Unfinshed Toggle!")
        

}



#Preview {
    GNButton({})
}
