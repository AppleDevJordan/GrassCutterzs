//
//  FloatingActionButton.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/19/25.
//
import SwiftUI


/// A little helper for each FAB option
struct FloatingActionButton: View {
    var icon: String
    var label: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Text(label)
                    .font(.caption)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.2), radius: 3, x: 0, y: 1)

                Image(systemName: icon)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
                    .shadow(radius: 5)
            }
        }
        .transition(.move(edge: .trailing).combined(with: .opacity))
    }
}
