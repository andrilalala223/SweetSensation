//
//  GiftCardView.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI

struct GiftCardView: View {
    
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
                    
                    StrokeText(text: "GIFT CARDS", width: 1.4, borderColor: .black, mainColor: .softPink)
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .padding(.vertical, -1)
                    
                    ScrollView {
                        Image("recPinkSmall")
                            .resizable()
                            .frame(width: size().width - 60, height: size().height / 2.7)
                            .opacity(0.8)
                            .padding(.top, 20)
                            .overlay {
                               
                            }
                        
                        Image("recBlueSmall")
                            .resizable()
                            .frame(width: size().width - 60, height: size().height / 2.7)
                            .opacity(0.8)
                            .padding(.top, 20)
                            .overlay {
                               
                            }
                        
                        Image("recPinkSmall")
                            .resizable()
                            .frame(width: size().width - 60, height: size().height / 2.7)
                            .opacity(0.9)
                            .padding(.top, 20)
                            .overlay {
                               
                            }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

#Preview {
    GiftCardView()
}
