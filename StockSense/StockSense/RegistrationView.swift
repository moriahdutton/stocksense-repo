//
//  RegistrationView.swift
//  StockSense
//
//  Created by Moriah Dutton on 3/5/25.
//


import SwiftUI

struct RegistrationView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var selectedRole: String = "Owner"
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    let roles = ["Owner", "Staff"]

    var body: some View {
        VStack(spacing: 20) {
            // MARK: - App Title
            Text("Create an Account")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 40)
            
            // MARK: - Name Field
            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

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

            // MARK: - Role Picker
            Picker("Select Role", selection: $selectedRole) {
                ForEach(roles, id: \.self) { role in
                    Text(role)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            // MARK: - Register Button
            Button(action: registerUser) {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }

            Spacer()

            // MARK: - Close Button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Close")
                    .foregroundColor(.red)
            }
            .padding(.top, 10)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    private func registerUser() {
        guard !name.isEmpty else {
            alertMessage = "Please enter your name."
            showAlert = true
            return
        }

        guard isValidEmail(email) else {
            alertMessage = "Please enter a valid email address."
            showAlert = true
            return
        }

        guard password.count >= 6 else {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            return
        }

        alertMessage = "User Registered Successfully!"
        showAlert = true
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
