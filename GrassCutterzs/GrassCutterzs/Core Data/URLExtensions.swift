//
//  URLExtensions.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/23/25.
//

import Foundation

extension URL {
    var isVideo: Bool {
        let videoExtensions = ["mov", "mp4", "m4v", "avi"]
        return videoExtensions.contains(self.pathExtension.lowercased())
    }
}

