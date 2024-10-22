//
//  OrderCell.swift
//  SweetSensation
//
//  Created by D K on 20.10.2024.
//

import SwiftUI

struct OrderCell: View {
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
                        .padding(.leading, 10)
                    
                    VStack(alignment: .leading) {
                        Text("Product name")
                        
                        Text("1.99")
                            .padding(.top, 1)
                        
                        Spacer()
                    }
                    .padding(.top)
                    .foregroundColor(.semiPurple)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    
                    Spacer()
                    
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
                    
                    Spacer()
                }
            }
    }
}

#Preview {
    OrderCell()
        .preferredColorScheme(.dark)
}
