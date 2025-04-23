//
//  CameraPicker.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/19/25.
//


import SwiftUI
import UIKit
import MobileCoreServices

struct CameraPicker: UIViewControllerRepresentable {
    /// Called with the URL of the recorded video, or `nil` on cancel.
    var onComplete: (URL?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onComplete: onComplete)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = [kUTTypeMovie as String]
        picker.videoQuality = .typeMedium
        picker.delegate = context.coordinator
        picker.cameraCaptureMode = .video
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // no-op
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let onComplete: (URL?) -> Void

        init(onComplete: @escaping (URL?) -> Void) {
            self.onComplete = onComplete
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            onComplete(nil)
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let mediaType = info[.mediaType] as? String
            if mediaType == (kUTTypeMovie as String),
               let url = info[.mediaURL] as? URL {
                onComplete(url)
            } else {
                onComplete(nil)
            }
        }
    }
}
