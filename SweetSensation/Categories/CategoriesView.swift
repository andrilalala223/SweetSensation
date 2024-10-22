//
//  AllProductView.swift
//  SweetSensation
//
//  Created by D K on 18.10.2024.
//

import SwiftUI

struct CategoriesView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isCartShown = false
    
    @State var cartItems = 0
    
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
                        
                        Button {
                            isCartShown.toggle()
                        } label: {
                            Image("cart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 20)
                                .padding(10)
                                .background {
                                    Circle()
                                        .foregroundColor(.white)
                                }
                                .overlay {
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            
                                            if cartItems > 0 {
                                                ZStack {
                                                    Circle()
                                                        .foregroundColor(.red)
                                                        .frame(width: 20, height: 20)
                                                    
                                                    Text("\(cartItems)")
                                                        .foregroundStyle(.white)
                                                }
                                            }
                                        }
                                    }
                                }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    StrokeText(text: "PRODUCTS", width: 1.4, borderColor: .black, mainColor: .softGreen)
                        .font(.system(size: 26, weight: .black, design: .rounded))
                        .padding(.vertical, -1)
                    
                    NavigationLink {
                        ProductsView(type: "ALL").navigationBarBackButtonHidden()
                    } label: {
                        Rectangle()
                            .frame(width: size().width - 70, height: 60)
                            .foregroundColor(.white)
                            .cornerRadius(54)
                            .overlay {
                                Text("ALL PRODUCTS")
                                    .foregroundColor(.semiPurple)
                                    .font(.system(size: 26, weight: .black, design: .rounded))
                            }
                    }
                    
                    VStack(spacing: 30) {
                        HStack(spacing: 30) {
                            NavigationLink {
                                ProductsView(type: "Sweet Bags").navigationBarBackButtonHidden()
                            } label: {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                                    .overlay {
                                        Image("Sweet Bags")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                            }
                            
                            
                            NavigationLink {
                                ProductsView(type: "Halloween").navigationBarBackButtonHidden()
                            } label: {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                                    .overlay {
                                        Image("Halloween")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                            }
                        }
                        
                        HStack(spacing: 30) {
                            NavigationLink {
                                ProductsView(type: "Freeze Dried").navigationBarBackButtonHidden()
                            } label: {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                                    .overlay {
                                        Image("Freeze Dried")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                            }
                            
                            NavigationLink {
                                ProductsView(type: "Crisps").navigationBarBackButtonHidden()
                            } label: {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                                    .overlay {
                                        Image("Crisps")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                            }
                        }
                        
                        HStack(spacing: 30) {
                            NavigationLink {
                                ProductsView(type: "Hanging Bags").navigationBarBackButtonHidden()
                            } label: {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                                    .overlay {
                                        Image("Hanging Bags")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                            }
                            
                            NavigationLink {
                                ProductsView(type: "Drinks").navigationBarBackButtonHidden()
                            } label: {
                                Rectangle()
                                    .frame(width: 120, height: 120)
                                    .foregroundColor(.white)
                                    .cornerRadius(24)
                                    .overlay {
                                        Image("Drinks")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                    }
                            }
                        }
                    }
                    .padding(30)
                    .background {
                        Image("recPink")
                            .resizable()
                            .opacity(0.8)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            cartItems = StorageManager.shared.sumQuantitiesInFirstCart()
        }
        .fullScreenCover(isPresented: $isCartShown) {
            CartView() {
                StorageManager.shared.deleteCart()
            }
            .onDisappear {
                cartItems = StorageManager.shared.sumQuantitiesInFirstCart()
            }
        }
    }
}

#Preview {
    CategoriesView()
}


struct StrokeText: View {
    let text: String
    let width: CGFloat
    let borderColor: Color
    let mainColor: Color
    
    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(borderColor)
            Text(text)
                .foregroundColor(mainColor)
        }
    }
}
