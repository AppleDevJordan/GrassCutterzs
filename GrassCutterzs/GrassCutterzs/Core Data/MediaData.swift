//
//  MediaData.swift
//  GrassCutterzs
//
//  Created by Jordan McKnight on 4/19/25.
//


import Foundation

class MediaData: ObservableObject {
    // MARK: – Published Properties
    @Published var savedMedia: [URL] = [] {
        didSet { saveToUserDefaults() }
    }

    @Published var showMediaPicker: Bool = false  // ← Add this!

    // MARK: – Init & Persistence
    private let userDefaultsKey = "savedMediaPaths"

    init() {
        loadFromUserDefaults()
    }

    private func saveToUserDefaults() {
        let paths = savedMedia.map(\.path)
        UserDefaults.standard.set(paths, forKey: userDefaultsKey)
    }

    func loadFromUserDefaults() {
        let paths = UserDefaults.standard.stringArray(forKey: userDefaultsKey) ?? []
        savedMedia = paths.compactMap {
            let url = URL(fileURLWithPath: $0)
            return FileManager.default.fileExists(atPath: url.path) ? url : nil
        }
    }

    // MARK: – Media Management
    func addMedia(_ url: URL) {
        guard !savedMedia.contains(url) else { return }
        savedMedia.append(url)
    }

    func deleteMedia(_ url: URL) {
        savedMedia.removeAll { $0 == url }
        removeFile(at: url)
    }

    func deleteMedia(at index: Int) {
        guard savedMedia.indices.contains(index) else { return }
        let url = savedMedia.remove(at: index)
        removeFile(at: url)
    }

    private func removeFile(at url: URL) {
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
            }
        } catch {
            print("⚠️ Error deleting file at \(url): \(error)")
        }
    }
}
