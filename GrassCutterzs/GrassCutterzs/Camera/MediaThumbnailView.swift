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
            ZStack(alignment: .bottomLeading) {
                Group {
                    if url.isVideo {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(width: 120, height: 120)
                            .clipped()
                    } else {
                        Image(uiImage: UIImage(contentsOfFile: url.path) ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipped()
                    }
                }
                .cornerRadius(10)
                .shadow(radius: 5)
                .onTapGesture { onTap() }
                
                ZStack(alignment: .bottomTrailing) {
                    if url.isVideo {
                        VideoPlayer(player: AVPlayer(url: url))
                            .frame(width: 120, height: 120)
                    } else {
                        Image(uiImage: UIImage(contentsOfFile: url.path) ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipped()
                    }
                    
                    if let duration = url.formattedDuration {
                        Text(duration)
                            .font(.caption2)
                            .padding(4)
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(5)
                            .padding(6)
                    }
                }
                
                
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
}
