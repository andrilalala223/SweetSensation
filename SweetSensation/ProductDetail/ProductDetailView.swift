//
//  ProductDetailView.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI

struct ProductDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var product: SweetProduct
    
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
                    
                    StrokeText(text: "PRODUCT \nDETAIL", width: 1.4, borderColor: .black, mainColor: .softPink)
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .padding(.vertical, -10)
                        .multilineTextAlignment(.center)
                    
                    ScrollView {
                        Image("recPinkSmall")
                            .resizable()
                            .frame(width: 320, height: 250)
                            .overlay {
                                Image(product.name)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 270, height: 210)
                                    .clipped()
                                    .cornerRadius(24)
                            }
                        
                        Rectangle()
                            .frame(width: size().width - 60, height: 70)
                            .foregroundColor(.white)
                            .cornerRadius(54)
                            .overlay {
                                HStack {
                                    Text(product.name)
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    
                                    Text(product.price)
                                        .foregroundColor(.semiPurple)
                                        .font(.system(size: 18, weight: .bold, design: .rounded))
                                }
                                .padding(.horizontal, 25)
                            }
                            .padding(.top, 10)
                        
//                        ScrollView {
//                            
//                        }
//                        .scrollIndicators(.hidden)
//                        .frame(width: size().width - 90, height: size().height / 3.5)
                        
                        Text(product.description)
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .black))
                        .padding(30)
                        .background {
                            Image("recBlue")
                                .resizable()
                        }
                        
//                       
//                            .frame(width: size().width - 60, height: size().height / 2.6)
//                            .padding(.top, 20)
//                            .overlay {
//                                
//                            }
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

//#Preview {
//    ProductDetailView()
//}
