//
//  MediaPicker.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/19/25.
//

import SwiftUI
import UIKit

struct MediaPicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var mediaData: MediaData

    let mediaType: MediaType
    let onMediaPicked: (URL?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator

        // Use MediaType for source & UTTypes
        picker.sourceType = mediaType.sourceType
        picker.mediaTypes = mediaType.mediaTypes

        if case .video = mediaType {
            picker.videoQuality = .typeHigh
        }

        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: MediaPicker

        init(parent: MediaPicker) {
            self.parent = parent
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
        ) {
            var selectedURL: URL?

            // Photo case
            if let image = info[.originalImage] as? UIImage {
                let filename = UUID().uuidString + ".jpg"
                let dest = FileManager.default
                    .urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent(filename)
                if let data = image.jpegData(compressionQuality: 1.0) {
                    try? data.write(to: dest)
                    selectedURL = dest
                }
            }

            // Video case
            if let videoURL = info[.mediaURL] as? URL {
                let docs = FileManager.default
                    .urls(for: .documentDirectory, in: .userDomainMask)[0]
                let dest = docs.appendingPathComponent(videoURL.lastPathComponent)
                do {
                    if FileManager.default.fileExists(atPath: dest.path) {
                        try FileManager.default.removeItem(at: dest)
                    }
                    try FileManager.default.copyItem(at: videoURL, to: dest)
                    selectedURL = dest
                } catch {
                    print("❌ MediaPicker copy error:", error)
                }
            }

            DispatchQueue.main.async { [self] in
                if let url = selectedURL {
                    parent.mediaData.addMedia(url)
                    parent.onMediaPicked(url)
                } else {
                    parent.onMediaPicked(nil)
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
