//
//  LoginView.swift
//  SweetSensation
//
//  Created by D K on 14.10.2024.
//

import SwiftUI

struct SigninView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isAlertShown = false
    @State private var switcher = true
    
    @ObservedObject var viewModel: AuthViewModel

    
    var body: some View {
        NavigationStack {
            ZStack {
                Background(bg: "bg2")
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 150)
                        .padding(.bottom, 30)
                    
                  
                            VStack {
                                TextField("", text: $email, prompt: Text("E-mail:").foregroundColor(.semiPurple.opacity(0.8)))
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .padding()
                                    .padding(.vertical, 5)
                                    .foregroundColor(.softPink)
                                    .tint(.softPink)
                                    .background {
                                        Rectangle()
                                            .foregroundColor(.white)
                                            .cornerRadius(24)
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 20)
                                
                                SecureField("", text: $password, prompt: Text("Password:").foregroundColor(.semiPurple.opacity(0.8)))
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .padding()
                                    .padding(.vertical, 5)
                                    .foregroundColor(.softPink)
                                    .tint(.softPink)
                                    .background {
                                        Rectangle()
                                            .foregroundColor(.white)
                                            .cornerRadius(24)
                                    }
                                    .padding(.horizontal, 25)
                                    .padding(.top, 20)
                                
                                Button {
                                    Task {
                                        try await viewModel.signIn(email: email, password: password)
                                    }
                                    withAnimation {
                                        isAlertShown.toggle()
                                    }
                                } label: {
                                    Text("SIGN IN")
                                        .font(.system(size: 26, weight: .black, design: .rounded))
                                        .foregroundColor(.semiPurple.opacity(0.8))
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 30)
                                .background {
                                    RoundedRectangle(cornerRadius: 33)
                                        .foregroundColor(.white)
                                }
                                .padding(.top)
                                
                                Button {
                                    Task {
                                        await viewModel.signInAnonymously()
                                    }
                                    withAnimation {
                                        isAlertShown.toggle()
                                    }
                                } label: {
                                    Text("ANONYMOUS \nLOGIN")
                                        .font(.system(size: 10, weight: .black, design: .rounded))
                                        .foregroundColor(.semiPurple.opacity(0.8))
                                }
                                .padding(.vertical, 15)
                                .padding(.horizontal, 30)
                                .background {
                                    RoundedRectangle(cornerRadius: 33)
                                        .foregroundColor(.white)
                                }
                                .padding(.top)
                                
                                NavigationLink {
                                    SignupView(viewModel: viewModel).navigationBarBackButtonHidden()
                                } label: {
                                    ZStack {
                                        Text("You don't have an account yet?\n".uppercased())
                                        + Text("Sign up ".uppercased())
                                            .foregroundColor(.semiPurple)
                                        + Text("now.".uppercased())
                                    }
                                    .foregroundColor(.white)
                                    .font(.system(size: 12))
                                }
                                .padding(.top, 30)
                                .padding(.bottom, 10)
                            }
                            //.padding(1)
                            .padding(.bottom, 10)
                            .background {
                                Image("recPink")
                                    .resizable()
                            }
                    
                    Spacer()
                }
            }
            .overlay {
                if isAlertShown {
                    ZStack {
                        Rectangle()
                            .ignoresSafeArea()
                            .foregroundColor(.white.opacity(0.1))
                        
                        if switcher {
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
                                        Text("Incorrect email or password.")
                                            .foregroundStyle(.black)
                                            .font(.system(size: 24, weight: .semibold, design: .monospaced))
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal)
                                        
                                        Button {
                                            withAnimation {
                                                isAlertShown = false
                                                switcher = true
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
                            switcher = false
                        }
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    SigninView()
//}
