//
//  VideoPlaybackView.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/23/25.
//


// VideoPlaybackManager.swift
// Manages timed + auto-ending video playback logic for GrassCutterzs

import SwiftUI
import AVKit

struct VideoPlaybackView: UIViewControllerRepresentable {
    let url: URL
    let isMuted: Bool
    let onPlaybackFinished: () -> Void

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerVC = AVPlayerViewController()
        playerVC.showsPlaybackControls = false
        playerVC.entersFullScreenWhenPlaybackBegins = false
        playerVC.exitsFullScreenWhenPlaybackEnds = false
        return playerVC
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        let player = AVPlayer(url: url)
        player.isMuted = isMuted

        // Add observer for early skip or max duration
        let maxDuration: CMTime = CMTime(seconds: 8, preferredTimescale: 1)
        let timeToCheck: CMTime = CMTime(seconds: 6.5, preferredTimescale: 1)

        player.addBoundaryTimeObserver(
            forTimes: [NSValue(time: timeToCheck)],
            queue: .main
        ) {
            onPlaybackFinished()
        }

        // Automatically skip after maxDuration just in case
        DispatchQueue.main.asyncAfter(deadline: .now() + CMTimeGetSeconds(maxDuration)) {
            onPlaybackFinished()
        }

        uiViewController.player = player
        player.play()
    }
}
