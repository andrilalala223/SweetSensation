//
//  ProductsView.swift
//  SweetSensation
//
//  Created by D K on 18.10.2024.
//

import SwiftUI

struct ProductsView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var products: [SweetProduct] = []
    var type: String
    
    @State var cartItems = 0
    @State var isCartShown = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background(bg: "bg2")
                
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
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    
                    StrokeText(text: "SWEET BAGS", width: 1.4, borderColor: .black, mainColor: .softPink)
                        .font(.system(size: 42, weight: .black, design: .rounded))
                        .padding(.vertical, -1)
                    
                    if !products.isEmpty {
                        Image("recBlue")
                            .resizable()
                            .frame(width: size().width - 60, height: size().height / 1.6)
                            .opacity(0.8)
                            .padding(.top, 20)
                            .overlay {
                                ScrollView {
                                    VStack {
                                        ForEach(products, id: \.name) { product in
                                            NavigationLink {
                                                ProductDetailView(product: product).navigationBarBackButtonHidden()
                                            } label: {
                                                ProductCell(product: product) {
                                                    cartItems = StorageManager.shared.sumQuantitiesInFirstCart()
                                                }
                                            }
                                        }
                                    }
                                }
                                .scrollIndicators(.hidden)
                                .frame(width: size().width - 60, height: size().height / 1.8)
                            }
                    }
                    
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            isCartShown.toggle()
                        } label: {
                            Image("cart")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
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
                        .padding(.bottom)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                }
            }
        }
        .onAppear {
            products = DataManager.shared.parseJSON(filename: "Products") ?? []
            products = DataManager.shared.filterSweetProductsByType(products: products, type: type)
            
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
    ProductsView(type: "Sweet Bags")
}
