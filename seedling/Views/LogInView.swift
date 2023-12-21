//
//  LogInView.swift
//  Seedling
//
//  Created by Brian Q on 11/28/22.
//

import Foundation
import SwiftUI

struct LogInView: View {
    @State var username: String = ""
    @State var password: String = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        let login = loginManager()
        VStack {
            Rectangle()
                .fill(Color(red: 0.6706, green: 0.8392, blue: 0.5765))
                .frame(width: 400, height: 100)
                .padding(.bottom, 80)
            Text("Login")
                .font(.system(size:45))
                .fontWeight(.semibold)
                .padding(.bottom, 10)
            //SeedlingImage()
            TextField("Username", text: $username)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                            .cornerRadius(5.0)
                            .padding(.bottom, 30)
            SecureField("Password", text: $password)
                            .padding()
                            .foregroundColor(Color.black)
                            .background(Color(red: 0.90, green: 0.90, blue: 0.90))
                            .cornerRadius(5.0)
                            .padding(.bottom, 30)
            Button(action: {login.signIn(email:username, password:password) {(success) in
                if (success) {
                    isLoggedIn = true
                } else {
                    isLoggedIn = false
                }
            }}) {
                           SignInButton()
                        }.padding(.bottom, 60)
            Text("No Account?")
                .padding(.bottom, 5)
            Button(action: {login.signUp(email:username, password:password) {(success) in
                if (success) {
                    isLoggedIn = true
                } else {
                    isLoggedIn = false
                }
            }})
                        {
                            SignUpButton()
                        }.padding(.bottom, 190)
        }
        .padding()
    }
}

struct SignInButton : View {
    var body: some View {
        return Text("SIGN IN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color(red: 0.898, green: 0.75, blue: 0.38))
            .cornerRadius(15.0)
    }
}

struct SignUpButton : View {
    var body: some View {
        return Text("SIGN UP")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60)
            .background(Color(red: 0.80, green: 0.80, blue: 0.80))
            .cornerRadius(15.0)
    }
}
