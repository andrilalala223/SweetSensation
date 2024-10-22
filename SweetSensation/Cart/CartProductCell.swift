//
//  CartProductCell.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI

struct CartProductCell: View {
    
    var completion: () -> ()
    
    var body: some View {
        Rectangle()
            .frame(width: size().width - 80, height: 75)
            .foregroundColor(.white)
            .cornerRadius(54)
            .overlay {
                HStack {
                    Text("Product name")
                        .foregroundColor(.semiPurple)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .frame(width: 100)
                    
                    Spacer()
                    
                    HStack {
                        Button {
                            
                        } label: {
                            Rectangle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.softBlue)
                                .cornerRadius(7)
                                .overlay {
                                    Image(systemName: "minus")
                                        .foregroundColor(.white)
                                        .bold()
                                }
                        }
                        
                        Text("1")
                            .foregroundColor(.semiPurple)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                            .frame(width: 20)
                        
                        Button {
                            
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
                    }
                }
                .padding(.horizontal, 25)
            }
    }
}
//
//#Preview {
//    CartProductCell()
//        .preferredColorScheme(.dark)
//}
