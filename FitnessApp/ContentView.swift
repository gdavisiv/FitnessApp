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
                .padding(.horizontal, 30)
                
                //Bar Chart
                VStack(alignment: .leading, spacing: 25) {
                    Text("Daily Workout in Hrs")
                        .font(.system(size: 22))
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    
                    HStack(spacing: 15) {
                        ForEach(workout_Data){ work in
                            VStack{
                                Text("2.5")
                                    .foregroundColor(Color("Color"))
                                
                                Rectangle()
                                    .fill(LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color")]), startPoint: .top, endPoint: .bottom))
                                    .frame(height: 200)
                                
                                Text(work.day)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        //Enables Dark Mode
        .preferredColorScheme(.dark)
    }
}

//Sample Data.. Struct + Array

struct Daily : Identifiable {
    var id : Int
    var day : String
    var workout_In_Min : CGFloat
}

var workout_Data = [

    Daily(id: 0, day: "Day 1", workout_In_Min: 480),
    Daily(id: 1, day: "Day 2", workout_In_Min: 880),
    Daily(id: 2, day: "Day 3", workout_In_Min: 250),
    Daily(id: 3, day: "Day 4", workout_In_Min: 360),
    Daily(id: 3, day: "Day 5", workout_In_Min: 1220),
    Daily(id: 3, day: "Day 6", workout_In_Min: 750),
    Daily(id: 3, day: "Day 7", workout_In_Min: 950)
]
