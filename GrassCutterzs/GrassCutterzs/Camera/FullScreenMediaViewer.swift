//
//  FullScreenMediaViewer.swift
//  GrassCutterzs
//
//  Updated – Removed internal volume toggle
//

import SwiftUI
import AVKit

struct FullScreenMediaViewer: View {
    @Binding var isPresented: Bool
    @Binding var isMuted: Bool
    var mediaItems: [URL]
    var startIndex: Int
    var onDelete: ((URL) -> Void)? = nil

    @State private var currentIndex: Int
    @State private var player: AVPlayer? = nil

    // Update initializer
    init(mediaItems: [URL],
         startIndex: Int = 0,
         isPresented: Binding<Bool>,
         isMuted: Binding<Bool>,
         onDelete: ((URL) -> Void)? = nil)
    {
        self.mediaItems = mediaItems
        self.startIndex = startIndex
        self._isPresented = isPresented
        self._isMuted = isMuted
        self._currentIndex = State(initialValue: startIndex)
        self.onDelete = onDelete
    }

    var body: some View {
        HStack(spacing: 0) {
            // Thumbnail strip (unchanged)
            MediaThumbnailStrip(
                mediaItems: mediaItems,
                currentIndex: $currentIndex,
                onDelete: onDelete ?? { _ in }
            )

            ZStack(alignment: .topTrailing) {
                // Main viewer
                MediaViewerContent(
                    mediaItems: mediaItems,
                    currentIndex: $currentIndex,
                    isPresented: $isPresented,
                    isMuted: $isMuted,
                    player: player ?? AVPlayer(),
                    onDelete: onDelete ?? { _ in }
                )
                .ignoresSafeArea()

                // Top-right controls: Close and Delete only
                HStack(spacing: 16) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }

                    if mediaItems.indices.contains(currentIndex),
                       let onDelete = onDelete
                    {
                        Button(action: {
                            let toDelete = mediaItems[currentIndex]
                            onDelete(toDelete)
                            isPresented = false
                        }) {
                            Image(systemName: "trash")
                                .font(.system(size: 24))
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                }
                .padding(.top, 40)
                .padding(.trailing, 20)
            }
        }
        .onAppear {
            loadPlayer(for: mediaItems[currentIndex])
        }
        .onChange(of: currentIndex) { newIndex in
            loadPlayer(for: mediaItems[newIndex])
        }
    }

    private func loadPlayer(for url: URL) {
        // Only one AVPlayer instance used, replacing its item
        if url.pathExtension.lowercased() == "mov" || url.pathExtension.lowercased() == "mp4" {
            let newItem = AVPlayerItem(url: url)
            if player == nil {
                player = AVPlayer(playerItem: newItem)
            } else {
                player?.replaceCurrentItem(with: newItem)
            }
            player?.play()
        } else {
            player?.pause()
            player = nil
        }
    }
}
