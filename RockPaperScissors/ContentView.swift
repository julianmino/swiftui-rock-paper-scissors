//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Julian Miño on 30/08/2023.
//

import SwiftUI

enum Move: String {
    case rock
    case paper
    case scissors
    
    static var random: Move {
        let array: [Move] = [.rock, .paper, .scissors]
        return array.randomElement() ?? .rock
    }
    
    var asString: String {
        switch self {
        case .rock:
            return "Rock"
        case .paper:
            return "Paper"
        case .scissors:
            return "Scissors"
        }
    }
}

struct ContentView: View {
    let options: [Move] = [.rock, .paper, .scissors]
    @State private var currentChoice: Move = .rock
    @State private var playerShouldWin = Bool.random()
    @State private var currentScore = 0
    @State private var appMove: Move = .random
    
    @State private var shouldPresentAlert = false
    
    var body: some View {
        ZStack {
            Color.red
                .ignoresSafeArea()
            Color.gray.opacity(0.5)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Text("Score: \(currentScore)")
                    .font(.title)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .foregroundStyle(.ultraThickMaterial)
                Spacer()
                VStack {
                    Text("The App's choice:")
                        .font(.title2)
                    Text("\(appMove.asString)")
                        .font(.largeTitle.bold())
                        .padding(20)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 40))
                Spacer()
                Text("If you want to score, you have to \(playerShouldWin ? "WIN" : "LOSE")!")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                HStack {
                    Spacer()
                    ForEach(options, id: \.self) { option in
                        Button(option.asString) {
                            validateScore(for: option)
                        }
                        .padding(20)
                        .background(.indigo)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .alert("You lose!", isPresented: $shouldPresentAlert) {
                            Button("OK") {
                                refresh()
                            }
                        } message: {
                            Text("You had to \(playerShouldWin ? "WIN" : "LOSE") the round.")
                        }
                        Spacer()
                    }
                }
                Spacer()
            }
            .padding(20)
        }
    }
    
    private func validateScore(for option: Move) {
        switch option {
        case .rock:
            if playerShouldWin {
                currentScore = appMove == .scissors ? currentScore + 1 : 0
            } else {
                currentScore = appMove == .paper ? currentScore + 1 : 0
            }
        case .paper:
            if playerShouldWin {
                currentScore = appMove == .rock ? currentScore + 1 : 0
            } else {
                currentScore = appMove == .scissors ? currentScore + 1 : 0
            }
        case .scissors:
            if playerShouldWin {
                currentScore = appMove == .paper ? currentScore + 1 : 0
            } else {
                currentScore = appMove == .rock ? currentScore + 1 : 0
            }
        }
        
        if currentScore == 0 {
            shouldPresentAlert = true
        } else {
            refresh()
        }
    }
    
    private func refresh() {
        appMove = .random
        playerShouldWin = .random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
