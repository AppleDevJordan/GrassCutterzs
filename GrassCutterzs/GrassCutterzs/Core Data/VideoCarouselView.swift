//
//  VideoCarouselView.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/23/25.
//


import SwiftUI
import AVKit

struct VideoCarouselView: View {
    @Binding var player: AVPlayer
    @Binding var isMuted: Bool
    @Binding var currentVideoIndex: Int
    @Binding var fadeTransition: Bool
    @Binding var animatePulse: Bool
    @Binding var showArrowHint: Bool

    var allVideos: [URL]
    var onSwipeLeft: () -> Void
    var onSwipeRight: () -> Void

    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        ZStack {
            if fadeTransition {
                Color.black.transition(.opacity)
            }

            VideoPlayer(player: player)
                .transition(.opacity)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            state = value.translation.width
                        }
                        .onEnded { value in
                            if value.translation.width < -50 {
                                onSwipeLeft()
                            } else if value.translation.width > 50 {
                                onSwipeRight()
                            }
                        }
                )

            // Mute toggle
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isMuted.toggle()
                        player.isMuted = isMuted
                    }) {
                        Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                            .padding()
                    }
                }
                Spacer()
            }

            // Swipe arrows with pulse
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
        }
    }
}
