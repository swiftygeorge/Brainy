//
//  ContentView.swift
//  Brainy
//
//  Created by George Mapaya on 2022-02-20.
//

import SwiftUI

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissors"]
    @State private var computerChoice = Int.random(in: 0 ..< 3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var playCount = 0
    @State private var gameStarted = false
    @State private var restartGame = false
    
    var linearGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        ZStack {
            // background
            linearGradient
                .ignoresSafeArea()
            
            // score, instructions e.t.c.
            VStack(spacing: 30) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        DetailColumn(text: "Computer Move:", secondaryText: gameStarted ? moves[computerChoice] : "")
                        
                        Spacer()
                        
                        DetailColumn(text: "Play To:", secondaryText: gameStarted && shouldWin ? "WIN" : gameStarted && shouldWin == false ? "LOSE" : "", trailing: true)
                    } //hstack
                } //vstack
                .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        GameButton(image: "rock")
                        Spacer()
                        GameButton(image: "paper")
                    } //hstack
                    
                    GameButton(image: "scissors")
                } //vstack
                
                Spacer()
                
                Text("\(gameStarted ? "Score: \(score)" : "")")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    // start game
                    Button {
                        gameStarted = true
                    } label: {
                        Text("START")
                            .bold()
                    } //button
                    .disabled(gameStarted == true)
                    
                    Spacer()
                    
                    // reset game
                    Button {
                        restartGame = true
                        // do something to reset the game
                    } label: {
                        Text("RESTART")
                            .bold()
                    } //button
                    .disabled(gameStarted == false)
                } //hstack
                .alert("Restart Game?", isPresented: $restartGame) {
                    Button("Cancel", role: .cancel, action: {})
                    Button("Restart", role: .destructive, action: restart)
                } message: {
                    Text("You'll lose all your progress if you perform this action.")
                } //alert
                
                Spacer()
            } //vstack
            .padding(.horizontal, 20)
        } //zstack
    }
    
    func restart() {
        gameStarted = false
    }
    
    func playGame() {
        
    }
}

struct GameButton: View {
    var image: String
    
    var body: some View {
        Button {
            // do something
        } label: {
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .padding(30)
                    .background(.white)
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

struct DetailColumn: View {
    var text: String
    var secondaryText: String
    var trailing: Bool = false
    
    var body: some View {
        VStack(alignment: trailing ? .trailing : .leading) {
            Text(text.uppercased())
                .font(.subheadline.weight(.light))
            Text(secondaryText.uppercased())
                .font(.title.bold())
        } //vstack
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
