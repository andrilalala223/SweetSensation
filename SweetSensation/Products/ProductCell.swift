//
//  ProductCell.swift
//  SweetSensation
//
//  Created by D K on 18.10.2024.
//

import SwiftUI

struct ProductCell: View {
    
    var product: SweetProduct
    
    var completion: () -> ()
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 100, height: 100)
            .cornerRadius(24)
            .foregroundColor(.softWhite)
            .overlay {
                HStack {
                    Circle()
                        .frame(width: 85, height: 85)
                        .foregroundColor(.softBlue)
                        .overlay {
                            Image(product.name)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 70, height: 70)
                                .clipShape(Circle())
                        }
                        .padding(.leading, 10)

                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .multilineTextAlignment(.leading)
                        Text(product.price)
                      //      .padding(.top, 1)
                        
                        Spacer()
                    }
                    .padding(.top)
                    .foregroundColor(.semiPurple)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .frame(width: 120,alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                        StorageManager.shared.addToCart(item: product)
                        completion()
                    } label: {
                        Rectangle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.softBlue)
                            .cornerRadius(7)
                            .overlay {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .bold()
                            }
                    }
                    .padding(.trailing)
                  //  Spacer()
                }
            }
    }
}

//#Preview {
//    ProductCell()
//        .preferredColorScheme(.dark)
//}
