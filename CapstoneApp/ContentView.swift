//
//  ContentView.swift
//  CapstoneApp
//
//  Created by 64001315 on 3/11/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @State private var showLoginView = false
    
    var body: some View {
        NavigationStack {
            VStack{
                ZStack{
                    Rectangle().size(width: 687.19, height: 259.88).rotation(Angle(degrees: 29.37)).transform(CGAffineTransform(translationX: -200, y: 10 )).fill(Color(red: 0.851, green: 0.851, blue: 0.851))
                    Text("EP Study Room")
                        .fontWeight(.semibold).font(.system(size: 48)).frame(width: 195, height: 300, alignment: .topLeading).multilineTextAlignment(.center)
                    
                }
                    Button(action: { showLoginView = true}) {
                        Text("Sign in")
                            .fontWeight(/*@START_MENU_TOKEN@*/.heavy/*@END_MENU_TOKEN@*/)
                            .font(.title3)
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(15)
                }
            }.padding().navigationDestination(isPresented: $showLoginView) {
                LoginView()
            }
        }
        }
    }

#Preview {
    ContentView()
}
