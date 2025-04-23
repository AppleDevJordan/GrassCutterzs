//
//  MediaThumbnailView.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/19/25.
//

import SwiftUI
import AVKit

struct MediaThumbnailView: View {
    let url: URL
    var onDelete: () -> Void
    var onTap: () -> Void

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Group {
                if url.pathExtension.lowercased() == "mov" || url.pathExtension.lowercased() == "mp4" {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(width: 120, height: 120)
                } else {
                    if let image = UIImage(contentsOfFile: url.path) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipped()
                    } else {
                        Color.gray
                            .frame(width: 120, height: 120)
                    }
                }
            }
            .cornerRadius(10)
            .shadow(radius: 5)
            .onTapGesture { onTap() }

            Button(action: onDelete) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Circle())
            }
            .offset(x: -5, y: 5)
        }
    }
}
