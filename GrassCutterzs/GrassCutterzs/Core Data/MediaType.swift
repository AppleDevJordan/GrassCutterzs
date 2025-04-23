//
//  MediaType.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/22/25.
//

import UIKit

enum MediaType {
    case photo(source: Source)
    case video(source: Source)

    enum Source {
        case camera
        case library
    }

    /// Determines whether the source is camera or photo library
    var sourceType: UIImagePickerController.SourceType {
        switch self {
        case .photo(let source), .video(let source):
            return source == .camera ? .camera : .photoLibrary
        }
    }

    /// UTType identifiers for media filtering in the picker
    var mediaTypes: [String] {
        switch self {
        case .photo:
            return ["public.image"]
        case .video:
            return ["public.movie"]
        }
    }

    /// Convenience initializers for clarity in other files
    static var photoFromCamera: MediaType {
        .photo(source: .camera)
    }

    static var photoFromLibrary: MediaType {
        .photo(source: .library)
    }

    static var videoFromCamera: MediaType {
        .video(source: .camera)
    }

    static var videoFromLibrary: MediaType {
        .video(source: .library)
    }
}
