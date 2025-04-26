//
//  HomeOverlayView.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/24/25.
//


import SwiftUI

struct HomeOverlayView: View {
    let currentIndex: Int
    let videoCount: Int
    let videoTitle: String

    @Binding var showArrowHint: Bool
    @Binding var animatePulse: Bool

    var body: some View {
        ZStack {
            VStack {
                Text("GrassCutterzs Reel")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .shadow(radius: 10)
                    .padding(.top, 60)

                Text(videoTitle)
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.85))
                    .shadow(radius: 5)
                    .padding(.top, 8)

                Spacer()
            }

            // Arrows animation
            if showArrowHint {
                HStack(spacing: 60) {
                    Image(systemName: "arrow.left.circle.fill")
                    Image(systemName: "arrow.right.circle.fill")
                }
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.85))
                .scaleEffect(animatePulse ? 1.2 : 1.0)
                .animation(.easeInOut(duration: 0.6).repeatCount(2, autoreverses: true), value: animatePulse)
                .onAppear {
                    animatePulse = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        showArrowHint = false
                    }
                }
            }

            // Indicators
            VStack {
                Spacer()
                HStack(spacing: 8) {
                    ForEach(0..<videoCount, id: \.self) { index in
                        Circle()
                            .frame(width: currentIndex == index ? 10 : 6,
                                   height: currentIndex == index ? 10 : 6)
                            .foregroundColor(currentIndex == index ? .white : .gray)
                            .opacity(currentIndex == index ? 1 : 0.5)
                            .animation(.easeInOut(duration: 0.2), value: currentIndex)
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
}
