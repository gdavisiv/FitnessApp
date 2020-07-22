//
//  ContentView.swift
//  FitnessApp
//
//  Created by George Davis IV on 7/22/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack{
                HStack{
                    Text("Hello George")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "slider.horizontal.3")
                            //.renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 30)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                }
                .padding()
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
