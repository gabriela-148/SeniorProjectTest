//
//  Settings.swift
//  SeniorProjectTest
//
//  Created by Gabriella Huegel on 3/24/24.
//

import SwiftUI

struct Settings: View {
    // Envi object so can have access to database calls
    @EnvironmentObject var viewModel: LoginController
    // States that keep track of when alerts or text fields are shown to the user
    @State private var showPassAlert = false
    @State private var showTextFields = false
    @State private var showErrorAlert = false
    
    // Variables to test whether the old pwd matches the user's pwd before changing it
    @State var oldPassword = ""
    @State var newPassword = ""
    
    
    var body: some View {
        VStack {
            Text("User Information") // Section header
                .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .foregroundColor(.black)
            Section {
                HStack {
                    Image(systemName: "person.circle")
                        .imageScale(.large)
                        .foregroundStyle(.white)
                        .frame(width: 75, height: 75)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius:10))
                        //.padding(.vertical)
                    // Displays users data
                    VStack(alignment: .leading, spacing: 6) {
                        Text("\(viewModel.name)")
                            .font(.system(size: 30))
                        
                        Text("\(viewModel.email)")
                            .font(.system(size: 20))
                            .tint(.gray)
                    }
                }//user info
            }
            Text("Edit Information") // Section header
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white)
                        .foregroundColor(.black)
            Section {
                // Shows the text fields to change the user's pwd if clicked
                Button {
                    showTextFields = true
                } label: {
                    Text("Change Password")
                        .font(.subheadline)
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 50)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius:10))
                        .padding()
                    
                }.alert(isPresented: $showPassAlert) { // if query is success shows this alert
                    Alert(title: Text("Success!"), message: Text("Password changed!"))
                }
                if showTextFields {
                    SecureField("Old Password", text: $oldPassword)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(.white)
                        .padding()
                        .cornerRadius(10)
                    
                    SecureField("New Password", text: $newPassword)
                        .foregroundColor(Color.black)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(.white)
                        .padding()
                        .cornerRadius(10)
                    
                    Button {
                        // if query is success sets the alert variables to true
                        if viewModel.resetPassword(username: viewModel.email, newPassword: newPassword, oldPassword: oldPassword) {
                            showPassAlert = true
                            showTextFields = false
                        }
                        
                        showErrorAlert = true
                        
                        
                    } label: {
                        Text("Submit")
                            .font(.subheadline)
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 50)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius:10))
                    }.alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Error"), message: Text("Invalid request"))
                    }
                    
                }// end of if
            }

            Spacer ()
            // User can signout if button is clicked, returns user to SignInScreen
            Button {
                viewModel.signOut()
            } label: {
                HStack {
                    Text("Log Out")
                        .font(.subheadline)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(.white)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
            }// end of button

        }
        
    }
}

#Preview {
    Settings()
}
