//
//  MediaThumbnailStrip.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/20/25.
//


import SwiftUI

struct MediaThumbnailStrip: View {
    let mediaItems: [URL]
    @Binding var currentIndex: Int
    var onDelete: ((URL) -> Void)? = nil

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(Array(0 ..< mediaItems.count), id: \.self) { index in
                    let url = mediaItems[index]
                    MediaThumbnailView(
                        url: url,
                        onDelete: {
                            onDelete?(url)
                        },
                        onTap: {
                            withAnimation(.easeInOut) {
                                currentIndex = index
                            }
                        }
                    )
                }
            }
            .padding(.vertical, 30)
            .padding(.leading, 10)
        }
        .frame(width: 100)
        .background(Color.black.opacity(0.85))
    }
}
