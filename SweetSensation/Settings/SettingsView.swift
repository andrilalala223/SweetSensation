//
//  SettingsView.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI
import MessageUI
import StoreKit


struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showingMailWithError = false
    @State private var showingMailWithSuggestion = false
    @State private var isDeleteAlertShown = false
    @State private var isAlertShown = false
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background(bg: "bg1")
                
                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .frame(width: 30, height: 20)
                                .bold()
                                .foregroundColor(.semiPurple)
                                .padding(10)
                                .background {
                                    Circle()
                                        .foregroundColor(.white)
                                }
                        }
                        Spacer()
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    
                    StrokeText(text: "SETTINGS", width: 1.4, borderColor: .black, mainColor: .softPink)
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .padding(.vertical, -1)
                    
                    ScrollView {
                        VStack(spacing: 15) {
                            Button {
                                if MFMailComposeViewController.canSendMail() {
                                    showingMailWithSuggestion.toggle()
                                } else {
                                    isAlertShown.toggle()
                                }
                            } label: {
                                Rectangle()
                                    .frame(width: size().width - 90, height: 60)
                                    .foregroundColor(.white)
                                    .cornerRadius(54)
                                    .overlay {
                                        Text("FEEDBACK")
                                            .foregroundColor(.semiPurple)
                                            .font(.system(size: 24, weight: .black, design: .rounded))
                                    }
                            }
                            .sheet(isPresented: $showingMailWithSuggestion) {
                                MailComposeView(isShowing: $showingMailWithSuggestion, subject: "Feedback", recipientEmail: "fabiodoppler48@yahoo.com", textBody: "")
                            }
                            
                            Button {
                                if MFMailComposeViewController.canSendMail() {
                                    showingMailWithError.toggle()
                                } else {
                                    isAlertShown.toggle()
                                }
                            } label: {
                                Rectangle()
                                    .frame(width: size().width - 90, height: 60)
                                    .foregroundColor(.white)
                                    .cornerRadius(54)
                                    .overlay {
                                        Text("REPORT A BUG")
                                            .foregroundColor(.semiPurple)
                                            .font(.system(size: 24, weight: .black, design: .rounded))
                                    }
                            }
                            .sheet(isPresented: $showingMailWithError) {
                                MailComposeView(isShowing: $showingMailWithError, subject: "Error message", recipientEmail: "fabiodoppler48@yahoo.com", textBody: "")
                            }
                            
                            Button {
                                openPrivacyPolicy()
                            } label: {
                                Rectangle()
                                    .frame(width: size().width - 90, height: 60)
                                    .foregroundColor(.white)
                                    .cornerRadius(54)
                                    .overlay {
                                        Text("PRIVACY POLICY")
                                            .foregroundColor(.semiPurple)
                                            .font(.system(size: 24, weight: .black, design: .rounded))
                                    }
                            }
                            
                            Button {
                                requestAppReview()
                            } label: {
                                Rectangle()
                                    .frame(width: size().width - 90, height: 60)
                                    .foregroundColor(.white)
                                    .cornerRadius(54)
                                    .overlay {
                                        Text("RATE THE APP")
                                            .foregroundColor(.semiPurple)
                                            .font(.system(size: 24, weight: .black, design: .rounded))
                                    }
                            }
                        }
                        .padding(30)
                        .background {
                            Image("recPinkSmall")
                                .resizable()
                                .opacity(0.8)
                        }
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            Image("orderButton")
                                .resizable()
                                .frame(width: 180, height: 80)
                                .overlay {
                                    Text("SIGN OUT")
                                        .foregroundColor(.white)
                                        .font(.system(size: 29, weight: .bold, design: .rounded))
                                }
                        }
                        .padding(.top)
                        
                        if authViewModel.currentuser != nil {
                            Button {
                                isDeleteAlertShown.toggle()
                            } label: {
                                Image("addButton")
                                    .resizable()
                                    .frame(width: 180, height: 80)
                                    .overlay {
                                        Text("Delete account")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                    }
                            }
                            .padding(.top)
                        }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
        .alert("Unable to send email", isPresented: $isAlertShown) {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
        .alert("Are you sure you want to delete your account?", isPresented: $isDeleteAlertShown) {
            Button {
                authViewModel.deleteUserAccount { result in
                    switch result {
                    case .success():
                        print("Account deleted successfully.")
                        authViewModel.userSession = nil
                        authViewModel.currentuser = nil
                    case .failure(let error):
                        print("ERROR DELELETING: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button {
                isDeleteAlertShown.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("To access your reserves you will need to create a new account.")
        }
    }
    
    func requestAppReview() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func openPrivacyPolicy() {
        if let url = URL(string: "https://sites.google.com/view/ssweetsensations/home") {
            UIApplication.shared.open(url)
        }
    }
}

//#Preview {
//    SettingsView()
//}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
