//
//  SignupView.swift
//  SweetSensation
//
//  Created by D K on 14.10.2024.
//

import SwiftUI

struct SignupView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    @ObservedObject var viewModel: AuthViewModel

    @State private var isNotificationShown = false
    @State private var switched = true
    @State private var isAlerted = false
    
    var body: some View {
        ZStack {
            Background(bg: "bg1")
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image("exit")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .padding()
                            .background {
                                Circle()
                                    .foregroundColor(.white)
                            }
                    }
                    
                    Spacer()
                }
                .padding(.top, 10)
                .padding(.leading, 20)
                
                StrokeText(text: "REGISTRATION", width: 1.4, borderColor: .black, mainColor: .softPink)
                    .font(.system(size: 42, weight: .black, design: .rounded))
                    .padding(.bottom, 20)
                
                Spacer()
                
                        VStack {
                            TextField("", text: $email, prompt: Text("E-mail:").foregroundColor(.semiBlue.opacity(0.8)))
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .padding()
                                .padding(.vertical, 5)
                                .foregroundColor(.semiBlue)
                                .tint(.semiBlue)
                                .background {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(24)
                                }
                                .padding(.horizontal, 25)
                                .padding(.top, 50)
                            
                            SecureField("", text: $password, prompt: Text("Password:").foregroundColor(.semiBlue.opacity(0.8)))
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .padding()
                                .padding(.vertical, 5)
                                .foregroundColor(.semiBlue)
                                .tint(.semiBlue)
                                .background {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(24)
                                }
                                .padding(.horizontal, 25)
                                .padding(.top, 20)
                            
                            SecureField("", text: $confirmPassword, prompt: Text("Confirm password:").foregroundColor(.semiBlue.opacity(0.8)))
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .autocorrectionDisabled()
                                .textInputAutocapitalization(.never)
                                .padding()
                                .padding(.vertical, 5)
                                .foregroundColor(.semiBlue)
                                .tint(.semiBlue)
                                .background {
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(24)
                                }
                                .padding(.horizontal, 25)
                                .padding(.top, 20)
                            
                            Button {
                                if isValid {
                                    Task {
                                        try await viewModel.createUser(withEmail: email, password: password)
                                    }
                                    withAnimation {
                                        isAlerted.toggle()
                                    }
                                } else {
                                    withAnimation {
                                        isAlerted.toggle()
                                    }
                                    isNotificationShown.toggle()
                                }
                            } label: {
                                Text("SIGN UP")
                                    .font(.system(size: 28, weight: .black, design: .rounded))
                                    .foregroundColor(.semiBlue)
                            }
                            .padding(.vertical, 15)
                            .padding(.horizontal, 30)
                            .background {
                                RoundedRectangle(cornerRadius: 33)
                                    .foregroundColor(.white)
                            }
                            .padding(.top, 30)
                            
                            
                            
                            Button {
                                dismiss()
                            } label: {
                                ZStack {
                                    Text("Already have an account?\n".uppercased())
                                    + Text("Sign in!".uppercased())
                                        .foregroundColor(.semiPurple)
                                }
                                .foregroundColor(.white)
                                .font(.system(size: 10))
                            }
                            .padding(.top, 30)
                            .padding(.bottom)
                            
                            Spacer()
                        }
                        .padding(1)
                        .background {
                            Image("recBlue")
                                .resizable()
                        }
            }

        }
        .overlay {
            if isAlerted {
                ZStack {
                    Rectangle()
                        .ignoresSafeArea()
                        .foregroundColor(.white.opacity(0.1))
                    
                    if switched {
                        Rectangle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                ProgressView()
                                    .tint(.purple)
                                    .controlSize(.large)
                            }
                    } else {
                        Rectangle()
                            .frame(width: 290, height: 250)
                            .foregroundColor(.white.opacity(0.9))
                            .blur(radius: 5)
                            .cornerRadius(24)
                            .shadow(color: .white.opacity(0.5), radius: 5)
                            .overlay {
                                VStack {
                                    Text("Incorrect data or user with this email already exists.")
                                        .foregroundStyle(.black)
                                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal)
                                    
                                    Button {
                                        withAnimation {
                                            isAlerted = false
                                            switched = true
                                            
                                            email = ""
                                            password = ""
                                            confirmPassword = ""
                                        }
                                    } label: {
                                       Image(systemName: "xmark")
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.black)
                                            .bold()
                                    }
                                    .padding(.top, 30)
                                }
                               
                            }
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        switched = false
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    SignupView()
//}


extension SignupView: AuthViewModelProtocol {
    var isValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
    }
}
