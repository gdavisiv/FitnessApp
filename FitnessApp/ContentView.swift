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
    //Create state for onTapGesture
    @State var selected = 0
    //Create a variable Color array that can be called upon
    var colors = [Color("Color1"), Color("Color")]
    var backgrnd = [Color.white.opacity(0.06)]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    
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
                                VStack{
                                    Spacer(minLength: 0)
                                    
                                    if selected == work.id {
                                        Text(getHrs(value: work.workout_In_Min))
                                            .foregroundColor(Color("Color"))
                                            .padding(.bottom)
                                    }
                                    //Gradient Bars: Great UI Effect!
                                    RoundedShape()
                                        .fill(LinearGradient(gradient: .init(colors: selected == work.id ? colors : backgrnd), startPoint: .top, endPoint: .bottom))
                                        .frame(height: getHeight(value: (work.workout_In_Min) * 3))
                                }
                                .frame(height: 120)
                                //Simple Animation that allows you to select each bar for a specific day
                                .onTapGesture {
                                    withAnimation(.easeOut){
                                        selected = work.id
                                    }
                                }
                                
                                Text(work.day)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white.opacity(0.06))
                .cornerRadius(10)
                .padding()
                
                HStack{
                    Text("Breakdown")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    
                    Spacer(minLength: 0)
                    
                }
                .padding()
                
                LazyVGrid(columns: columns,spacing: 30){
                    ForEach(stats_Data){ stats in
                        VStack(spacing: 22){
                            HStack{
                                Text(stats.title)
                                    .font(.system(size: 22))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                
                                Spacer(minLength: 0)
                            }
                                //Ring
                                ZStack{
                                    Circle()
                                        .trim(from: 0, to: 1)
                                        .stroke(stats.color.opacity(0.25), lineWidth: 10)
                                        .frame(width: (UIScreen.main.bounds.width - 150)/2, height: (UIScreen.main.bounds.width - 150) / 2)
                                    Circle()
                                        .trim(from: 0, to: (stats.currentData / stats.goal))
                                        .stroke(stats.color, style: StrokeStyle(lineWidth: 10, lineCap: .butt))
                                        .frame(width: (UIScreen.main.bounds.width - 150)/2, height: (UIScreen.main.bounds.width - 150) / 2)
                                    Text(getPercent(current: stats.currentData, Goal: stats.goal) + " %")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(stats.color)
                                        //Rotates the bar so it begins at 12'clock
                                        .rotationEffect(.init(degrees: 90))
                                }
                                //Fixes rotation on all elements in HStack
                                .rotationEffect(.init(degrees: -90))
                            
                                Text(getDec(val: stats.currentData) + " " + getType(val: stats.title))
                                    .font(.system(size: 22))
                                    .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                    .fontWeight(.bold)
                                    .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.2), radius: 10, x: 0, y: 0)
                            }
                            .padding()
                            .background(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.06))
                            .cornerRadius(15)
                            .shadow(color: Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)).opacity(0.2), radius: 10, x: 0, y: 0)
                        
                    }
                }
                .padding(.horizontal, 8)
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        //Enables Dark Mode
        .preferredColorScheme(.dark)
    }
    
    //Calculating the Type..
    func getType(val: String)->String{
        switch val {
            case "Water": return "L"
            case "Sleep": return "Hrs"
            case "Running": return "Mi"
            case "Cycling": return "Mi"
            case "Steps": return "Steps"
            default: return "Kcal"
        }
    }
    
    //Converting Numbers to Decimals
    func getDec(val: CGFloat)->String{
        let format = NumberFormatter()
        format.numberStyle = .decimal
        
        return format.string(from: NSNumber.init(value: Float(val)))!
    }
    
    //Calculates the percentage for the stats area
    func getPercent(current: CGFloat, Goal : CGFloat)->String{
        let per = (current / Goal) * 100
        return String(format: "%.1f", per)
    }
    
    //Calculating the Hours and converting into a height
    //Max height = 200
    func getHeight(value : CGFloat) -> CGFloat{
        //Convert value into minutes
        //24hrs = 1440 mins
        let hrs = CGFloat(value / 1440) * 200
        return hrs
    }
    
    //Calculating Hours
    func getHrs(value: CGFloat)->String{
        let hrs = value / 60
        
        return String(format: "%.1f", hrs)
    }
}

struct RoundedShape : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 5, height: 5))
        
        return Path(path.cgPath)
    }
}

//Sample Data.. Struct + Array
struct Daily : Identifiable {
    var id : Int
    var day : String
    var workout_In_Min : CGFloat
}

var workout_Data = [

    Daily(id: 0, day: "Day 1", workout_In_Min: 60),
    Daily(id: 1, day: "Day 2", workout_In_Min: 100),
    Daily(id: 2, day: "Day 3", workout_In_Min: 120),
    Daily(id: 3, day: "Day 4", workout_In_Min: 80),
    Daily(id: 4, day: "Day 5", workout_In_Min: 180),
    Daily(id: 5, day: "Day 6", workout_In_Min: 115),
    Daily(id: 6, day: "Day 7", workout_In_Min: 75)
]

struct Stats : Identifiable {
    var id : Int
    var title : String
    var currentData : CGFloat
    var goal : CGFloat
    var color : Color
}

var stats_Data = [
    Stats(id: 0, title: "Running", currentData: 6.8, goal: 15, color: Color("running")),
    Stats(id: 1, title: "Water", currentData: 3.5, goal: 5, color: Color("water")),
    Stats(id: 2, title: "Calories", currentData: 585, goal: 1000, color: Color("energy")),
    Stats(id: 3, title: "Sleep", currentData: 6.2, goal: 8, color: Color("sleep")),
    Stats(id: 4, title: "Cycling", currentData: 12.5, goal: 25, color: Color("cycle")),
    Stats(id: 5, title: "Steps", currentData: 16889, goal: 20000, color: Color("steps"))
]
