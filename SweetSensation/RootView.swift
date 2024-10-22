//
//  RootView.swift
//  SweetSensation
//
//  Created by D K on 21.10.2024.
//

import SwiftUI

struct RootView: View {
    @StateObject private var viewModel = AuthViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                HomeView()
                    .environmentObject(viewModel)
            } else {
                SigninView(viewModel: viewModel)
            }
        }
    }
}
//
//#Preview {
//    RootView()
//}
