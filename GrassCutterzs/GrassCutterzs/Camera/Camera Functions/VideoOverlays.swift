//
//  VideoOverlays.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/24/25.
//


import SwiftUI

struct VideoOverlays: View {
    let currentIndex: Int
    let total: Int
    let skipIntro: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Skip Intro") {
                    skipIntro()
                }
                .padding(10)
                .background(Color.black.opacity(0.6))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding()
            }

            Spacer()

            HStack(spacing: 8) {
                ForEach(0..<total, id: \.self) { i in
                    Circle()
                        .frame(width: currentIndex == i ? 10 : 6, height: currentIndex == i ? 10 : 6)
                        .foregroundColor(currentIndex == i ? .white : .gray)
                        .opacity(currentIndex == i ? 1 : 0.5)
                        .onTapGesture {
                            NotificationCenter.default.post(name: .AVPlayerItemDidPlayToEndTime, object: nil)
                        }
                }
            }
            .padding(.bottom, 30)
        }
    }
}
