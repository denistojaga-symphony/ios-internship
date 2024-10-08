//
//  RegistrationScreenView.swift
//  InternshipApp
//
//  Created by Sead Mašetić on 19. 8. 2024..
//

import SwiftUI

struct RegistrationScreenView: View {
    
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var flightViewModel: FlightViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                ContainerRelativeShape()
                    .fill(.blue)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        VStack {
                            Text("Register")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                            Text("Create your account")
                                .font(.callout)
                                .foregroundStyle(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            VStack(alignment: .leading) {
                                TextFieldInput(label: "Your name",
                                               placeholder: "Enter your name",
                                               text: $userViewModel.name,
                                               iconName: "")
                                if userViewModel.registrationAttempted && userViewModel.name.isEmpty {
                                    Text("Name is required")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                TextFieldInput(label: "Your surname",
                                               placeholder: "Enter your surname",
                                               text: $userViewModel.surname,
                                               iconName: "")
                                if userViewModel.registrationAttempted && userViewModel.surname.isEmpty {
                                    Text("Surname is required")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                NumberPickerInput(label: "Enter your age",
                                                  value: $userViewModel.age)
                                if userViewModel.registrationAttempted && userViewModel.age <= 0 {
                                    Text("Age must be greater than 0")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                TextFieldInput(label: "Your email",
                                               placeholder: "Enter your email",
                                               text: $userViewModel.email,
                                               iconName: "")
                                
                                if userViewModel.registrationAttempted && !userViewModel.validateEmail() {
                                    Text("Email is invalid")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(alignment: .leading) {
                                PasswordTextField(text: $userViewModel.password)
                                
                                if userViewModel.registrationAttempted && !userViewModel.validatePassword() {
                                    Text("Password must be at least 8 characters long, contain an uppercase letter, a lowercase letter, a digit, and a special character.")
                                        .foregroundStyle(.red)
                                        .font(.footnote)
                                }
                            }
                            

                            VStack(spacing: 24) {
                                ButtonView(title: "Register",
                                           style: .primary,
                                           action: {
                                    userViewModel.registrationAttempted = true

                                    if userViewModel.validate() {
                                        Task {
                                            do {
                                                try await userViewModel.signUp()
                                                print("Created account!")
                                                userViewModel.registrationAttempted = false
                                            } catch {
                                                userViewModel.alertMessage = "Failed to create account: \(error.localizedDescription)"
                                                userViewModel.showAlert = true
                                            }
                                        }
                                    } else {
                                        userViewModel.alertMessage = "Please ensure all fields are correctly filled out."
                                        userViewModel.showAlert = true
                                    }
                                })
                                .alert(isPresented: $userViewModel.showAlert) {
                                    Alert(title: Text("Registration Error"),
                                          message: Text(userViewModel.alertMessage),
                                          dismissButton: .default(Text("OK")))
                                }
                                
                                Button {
                                } label: {
                                    NavigationLink(destination: LoginScreenView(userViewModel: UserViewModel(), flightViewModel: flightViewModel)) {
                                        Text("Already have an account?")
                                    }
                                }
                                .buttonStyle(.plain)
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                                .padding()
                            }
                        }
                        .padding(24)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 15, height: 10)))
                        .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    RegistrationScreenView(userViewModel: UserViewModel(), flightViewModel: FlightViewModel())
}
