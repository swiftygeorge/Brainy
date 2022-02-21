//
//  GameButton.swift
//  Brainy
//
//  Created by George Mapaya on 2022-02-21.
//

import SwiftUI

struct GameButton: View {
    @Binding var answer: String
    
    var image: String
    var playGame: () -> Void
    
    var body: some View {
        Button {
            answer = image.capitalized
            playGame()
        } label: {
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                    .background(.thickMaterial)
                    .clipShape(Circle())
                    .padding(5)
                    .background(.blue)
                    .frame(maxWidth: 150, maxHeight: 150)
                    .clipShape(Circle())
            } //zstack
        } //button
        .shadow(radius: 5)
    }
}

/*
struct GameButton_Previews: PreviewProvider {
    static var previews: some View {
        GameButton(answer: <#Binding<String>#>, image: "rock", playGame: <#() -> Void#>)
    }
}
*/
