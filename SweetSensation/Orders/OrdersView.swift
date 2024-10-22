//
//  OrdersView.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI

struct OrdersView: View {
    
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        NavigationStack {
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
                                .frame(width: 30, height: 20)
                                .padding(10)
                                .background {
                                    Circle()
                                        .foregroundColor(.white)
                                }
                        }
                        
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    StrokeText(text: "ORDERS", width: 1.4, borderColor: .black, mainColor: .softPink)
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .padding(.vertical, -1)
                    
                    Image("recBlue")
                        .resizable()
                        .frame(width: size().width - 60, height: size().height / 1.6)
                        .padding(.top, 20)
                        .overlay {
                            VStack {
                                Spacer()
                                Text("You don't have any orders yet.")
                                
                                Spacer()
                                
                                Image(systemName: "cart")
                                    .font(.system(size: 92, weight: .thin, design: .rounded))
                                
                                Spacer()
                                 
                                 Text("Orders will appear after they are confirmed by the manager.")
                                Spacer()
                            }
                            .font(.system(size: 32, weight: .thin, design: .rounded))
                            .foregroundColor(.black.opacity(0.5))
                            .padding(.horizontal, 40)
                        }
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OrdersView()
}
