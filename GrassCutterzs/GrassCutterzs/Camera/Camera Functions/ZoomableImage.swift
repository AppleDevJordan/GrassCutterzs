//
//  ZoomableImage.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/20/25.
//
import SwiftUI
import AVKit
import Photos


struct ZoomableImage: View {
    let image: Image
    @State private var scale: CGFloat = 1.0
    @GestureState private var gestureScale: CGFloat = 1.0

    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .scaleEffect(scale * gestureScale)
            .gesture(
                MagnificationGesture()
                    .updating($gestureScale) { value, state, _ in
                        state = value
                    }
                    .onEnded { value in
                        scale *= value
                    }
            )
            .animation(.easeInOut, value: scale * gestureScale)
            .edgesIgnoringSafeArea(.all)
    }
}

//private extension URL {
//    var isVideo: Bool {
//        let ext = pathExtension.lowercased()
//        return ext == "mp4" || ext == "mov" || ext == "m4v"
//    }
//}
//
