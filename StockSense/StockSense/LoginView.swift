//
//  LoginView.swift
//  StockSense
//
//  Created by Moriah Dutton on 3/5/25.
//


import SwiftUI

struct LoginView: View {
    // MARK: - State Variables
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegistrationView: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Binding var isLoggedIn: Bool // Binding to track login state

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - App Title
            Text("StockSense")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)

            // MARK: - Email Field
            TextField("Enter your email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            // MARK: - Password Field
            SecureField("Enter your password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            // MARK: - Login Button
            Button(action: loginUser) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            // MARK: - Register Button
            Button(action: {
                showRegistrationView = true
            }) {
                Text("Don't have an account? Register")
                    .foregroundColor(.blue)
            }
            .padding(.top, 10)

            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Login"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .fullScreenCover(isPresented: $showRegistrationView) {
            RegistrationView()
        }
    }

    // MARK: - Login Logic
    private func loginUser() {
        // Basic validation
        guard !email.isEmpty else {
            alertMessage = "Please enter your email."
            showAlert = true
            return
        }

        guard !password.isEmpty else {
            alertMessage = "Please enter your password."
            showAlert = true
            return
        }

        // Simulate login (replace with actual authentication logic)
        if email == "test@example.com" && password == "password" {
            isLoggedIn = true // Update login state
        } else {
            alertMessage = "Invalid email or password."
            showAlert = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isLoggedIn: .constant(false))
    }
}