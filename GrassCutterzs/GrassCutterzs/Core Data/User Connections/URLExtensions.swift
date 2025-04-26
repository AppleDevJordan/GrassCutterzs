//
//  URLExtensions.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/23/25.
//

import Foundation
import AVFoundation

extension URL {
    /// Checks if the URL has a known video file extension.
    var isVideo: Bool {
        let videoExtensions = ["mp4", "mov", "m4v"]
        return videoExtensions.contains(pathExtension.lowercased())
    }

    /// Converts the file name into a readable title.
    var prettyTitle: String {
        let rawName = deletingPathExtension().lastPathComponent
        let words = rawName
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "-", with: " ")
            .components(separatedBy: .whitespaces)
            .filter { !$0.isEmpty }

        return words.map { $0.capitalized }.joined(separator: " ")
    }

    /// Retrieves the duration of a video at this URL (in seconds).
    var videoDuration: Double? {
        let asset = AVAsset(url: self)
        let duration = asset.duration
        return CMTimeGetSeconds(duration).isNaN ? nil : CMTimeGetSeconds(duration)
    }

    /// Returns a formatted string for the video duration (e.g., "1:23")
    var formattedDuration: String? {
        guard let totalSeconds = videoDuration else { return nil }
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
