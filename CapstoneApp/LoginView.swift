//
//  LoginView.swift
//  CapstoneApp
//
//  Created by 64001315 on 3/12/24.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showMainView = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Rectangle().size(width: 687.19, height: 259.88).rotation(Angle(degrees: 29.37)).transform(CGAffineTransform(translationX: -200, y: 10 )).fill(Color(red: 0.957, green: 0.957, blue: 0.957))
                VStack{
                    Text("Sign in")
                        .fontWeight(.semibold).font(.system(size: 48))
                    InputFieldView(data: $username, title: "Username")
                    PasswordFieldView(data: $password, title: "Password")
                    Button(action: { if (username == "admin" && password == "password") {
                        showMainView = true
                    } else {
                        showAlert = true
                    }}) {
                        Text("Sign in")
                            .fontWeight(/*@START_MENU_TOKEN@*/.heavy/*@END_MENU_TOKEN@*/)
                            .font(.title3)
                            .padding()
                            .foregroundColor(.white)
                            .background(.red)
                            .cornerRadius(15)
                    }

                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Cannot Log In"),
                        message: Text("Incorrect username or password."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
            }.navigationDestination(isPresented: $showMainView) {
                MainScreenView().navigationBarBackButtonHidden(true)
            }
        }
    }
}

#Preview {
    LoginView()
}
