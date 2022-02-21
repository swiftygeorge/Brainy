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
    @State private var playCount = 1
    @State private var gameStarted = false
    @State private var gameRestarted = false
    @State private var gameOver = false
    @State private var userAnswer = ""
    
    var linearGradient: LinearGradient = LinearGradient(gradient: Gradient(colors: [.blue, .red]), startPoint: .top, endPoint: .bottom)
    
    var radialGradient: RadialGradient = RadialGradient(stops: [.init(color: Color("redish"), location: 0.3), .init(color: Color("purpleish"), location: 0.3)], center: .top, startRadius: 200, endRadius: 400)
    
    var body: some View {
        ZStack {
            // background
            radialGradient
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
                Spacer()
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        GameButton(answer: $userAnswer, image: "rock", playGame: playGame)
                        Spacer()
                        GameButton(answer: $userAnswer, image: "paper", playGame: playGame)
                    } //hstack
                    
                    GameButton(answer: $userAnswer, image: "scissors", playGame: playGame)
                } //vstack
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                HStack(alignment: .firstTextBaseline, spacing: 5) {
                    Text("\(gameOver ? "Final Score:" : "Score:")")
                        .font(.title.weight(.medium))
                    Text("\(score)")
                        .font(.largeTitle.weight(.medium))
                } //hstack
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
                        gameRestarted = true
                        // do something to reset the game
                    } label: {
                        Text("RESTART")
                            .bold()
                    } //button
                    .disabled(gameStarted == false)
                } //hstack
                .alert("Restart Game?", isPresented: $gameRestarted) {
                    Button("Cancel", role: .cancel, action: {})
                    Button("Restart", role: .destructive, action: restartGame)
                } message: {
                    Text("You'll lose all your progress if you perform this action.")
                } //alert
                .alert("Game Over!", isPresented: $gameOver) {
                    Button("Cancel", role: .cancel) {
                        restartGame()
                        gameStarted = false
                    }
                    Button("Play Again", action: restartGame)
                } message: {
                    Text("Your final score is \(score). Do you want to play again?")
                }
                
                Spacer()
            } //vstack
            .padding(.horizontal, 20)
        } //zstack
    }
    
    func restartGame() {
        computerChoice = Int.random(in: 0 ..< 3)
        shouldWin.toggle()
        score = 0
        playCount = 1
        userAnswer = ""
    }
    
    func playGame() {
        let didPlayerWin = playerWon()
        
        if shouldWin == didPlayerWin {
            score += 1
        } else {
            score -= 1
        } //if-else
        
        if playCount < 10 {
            playCount += 1
            computerChoice = Int.random(in: 0 ..< 3)
            shouldWin.toggle()
        } else {
            gameOver = true
        } //if-else
    }
    
    func playerWon() -> Bool {
        let computerSelection = moves[computerChoice]
        
        switch true {
        case userAnswer == "Paper" && computerSelection == "Rock":
            return true
        case userAnswer == "Scissors" && computerSelection == "Rock":
            return false
        case userAnswer == "Rock" && computerSelection == "Paper":
            return false
        case userAnswer == "Scissors" && computerSelection == "Paper":
            return true
        case userAnswer == "Rock" && computerSelection == "Scissors":
            return true
        case userAnswer == "Paper" && computerSelection == "Scissors":
            return false
        default:
            return false
        } //switch
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
