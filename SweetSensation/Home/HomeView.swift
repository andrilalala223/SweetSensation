//
//  HomeView.swift
//  SweetSensation
//
//  Created by D K on 14.10.2024.
//

import SwiftUI

struct HomeView: View {
    
    
    @State var isSettingsShown = false
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background(bg: "bg3")
                
                VStack {
                    Image("logo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 150)
                        .padding(.bottom, 30)
                    
                    VStack(spacing: 30) {
                        NavigationLink {
                            CategoriesView().navigationBarBackButtonHidden()
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 60, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(54)
                                .overlay {
                                    Text("PRODUCTS")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 28, weight: .black, design: .rounded))
                                }
                        }
                        
                        NavigationLink {
                            OrdersView().navigationBarBackButtonHidden()
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 60, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(54)
                                .overlay {
                                    Text("ORDERS")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 28, weight: .black, design: .rounded))
                                }
                        }
                        
                        NavigationLink {
                            AboutView().navigationBarBackButtonHidden()
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 60, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(54)
                                .overlay {
                                    Text("ABOUT")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 28, weight: .black, design: .rounded))
                                }
                        }
                        
                        
                        NavigationLink {
                            SettingsView().environmentObject(authViewModel).navigationBarBackButtonHidden()
                        } label: {
                            Rectangle()
                                .frame(width: size().width - 60, height: 70)
                                .foregroundColor(.white)
                                .cornerRadius(54)
                                .overlay {
                                    Text("SETTINGS")
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 28, weight: .black, design: .rounded))
                                }
                        }
                    }
                    
                    Spacer()
                }
            
            }
        }

    }
}

//#Preview {
//    HomeView()
//}
