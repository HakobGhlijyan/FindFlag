//
//  ContentView.swift
//  lesson16-17FindFLag
//
//  Created by Hakob Ghlijyan on 22.05.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Австрия","Аргентина","Армения","Бразилия","Бельгия","Канада","Нидерланды","Португалия","Россия","США","Швейцария","Япония"].shuffled()
    
    @State private var currentAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40.0) {
                
                Spacer()
                
                VStack {
                    Text("Выбери флаг: ")
                        .foregroundColor(.white)
                        .font(.headline)
                    Text(countries[currentAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button (action: {
                        self.flagTapped(number)
                        self.showingScore = true
                    }) {
                        Image(self.countries[number])
                            .resizable()
                            .renderingMode(.original)
                            .frame(width: 250, height: 150)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 2))
                            .shadow(color: Color.blue, radius: 2)
                    }
                }
                Text("Общий счет: \(score)")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Общий счет: \(score)"), dismissButton: .default(Text("Продолжить")){
                self.askQustion()
            })
        }

    }
    
    func askQustion() {
        countries.shuffle()
        currentAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number:Int) {
        if number == currentAnswer{
            scoreTitle = "Правильный ответ!"
            score += 1
        } else {
            scoreTitle = "Неправильно! Это флаг \(countries[number])"
            score -= 1
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
