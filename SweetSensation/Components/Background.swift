//
//  Background.swift
//  SweetSensation
//
//  Created by D K on 14.10.2024.
//

import SwiftUI

struct Background: View {
    var bg: String
    
    var body: some View {
        ZStack {
            Image(bg)
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    Background(bg: "bg2")
}
