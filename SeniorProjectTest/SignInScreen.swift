//
//  ContentView.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 2/6/24.
//

import SwiftUI
import SQLite3
import Foundation

struct SignInScreen: View {
    // Variables to test user input is in database
    @State var email = ""
    @State var password = ""
    @State private var showAlert = false
    @State private var showNextView = false
    @State private var login = true
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    
    var tan = Color(red: 255/255, green: 247/255, blue: 229/255)
    
    var body: some View {
        
        GeometryReader { geo in
            ZStack {
                //Background
                Rectangle()
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.all)
                // Images for UI to look pretty
                VStack {
                    Image("myfoodprint")
                        .frame(width: 350, height: 350, alignment: .center)
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .padding()
                    
                    TextField("Email Address", text: $email)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.gray, lineWidth: 2)
                                .padding(1)
                        )
                        .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40)) // Add padding as needed

                    SecureField("Password", text: $password)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.gray, lineWidth: 2)
                                .padding(1)
                        )
                        .padding(EdgeInsets(top: 20, leading: 40, bottom: 20, trailing: 40)) // Add padding as needed
                    
                    // Checks if user input is in the database
                    Button(action: {
                        if !viewModel.login(username: email, password: password) {
                            showAlert = true
                        }
                        
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    })
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Login Failed"),
                            message: Text("Invalid credentials"),
                            dismissButton: .default(Text("OK")))
                    }

                    
                    Spacer()
                    
                }
                .padding()
                
            }// v stack
            
        }// z stack
        .animation(.easeIn, value: true)
    }//body
    
}//struct

#Preview {
    SignInScreen()
}
