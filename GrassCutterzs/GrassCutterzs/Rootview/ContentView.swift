//
//  ContentView.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/18/25.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Welcome to GrassCutterzs!")
                    .font(.title)
                
                NavigationLink(destination: RootView()) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.green)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
