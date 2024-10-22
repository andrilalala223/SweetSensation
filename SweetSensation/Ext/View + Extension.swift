//
//  View + Extension.swift
//  SweetSensation
//
//  Created by D K on 14.10.2024.
//

import SwiftUI

extension View {
    func size() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
