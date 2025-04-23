//
//  MediaViewerContent.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/21/25.
//


import SwiftUI
import AVKit

struct MediaViewerContent: View {
    let mediaItems: [URL]
    @Binding var currentIndex: Int
    @Binding var isPresented: Bool
    @Binding var isMuted: Bool
    var player: AVPlayer
    var onDelete: (URL) -> Void

    @GestureState private var dragOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width

            TabView(selection: $currentIndex) {
                ForEach(mediaItems.indices, id: \.self) { index in
                    ZStack {
                        Color.black.ignoresSafeArea()

                        if mediaItems[index].pathExtension == "mp4" || mediaItems[index].pathExtension == "mov" {
                            VideoPlayer(player: index == currentIndex ? player : nil)
                                .onAppear {
                                    if index == currentIndex {
                                        player.replaceCurrentItem(with: AVPlayerItem(url: mediaItems[index]))
                                       player.isMuted = isMuted
                                        player.play()
                                    }
                                }
                        } else if mediaItems[index].pathExtension == "jpg" || mediaItems[index].pathExtension == "png" {
                            Image(uiImage: UIImage(contentsOfFile: mediaItems[index].path) ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                        }
                    }
                    .tag(index)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .contentShape(Rectangle())
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
            )
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            onDelete(mediaItems[currentIndex])
                        }) {
                            Label("Delete", systemImage: "trash")
                                .padding()
                                .background(Color.red.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }

                        Spacer()

                        Button(action: {
                            isPresented = false
                        }) {
                            Label("Close", systemImage: "xmark.circle.fill")
                                .padding()
                                .background(Color.gray.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                },
                alignment: .bottom
            )
        }
    }
}
