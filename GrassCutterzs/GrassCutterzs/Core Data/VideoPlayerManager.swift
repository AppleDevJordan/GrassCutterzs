import Foundation
import AVKit

class VideoPlayerManager: ObservableObject {
    let player = AVQueuePlayer()
    private var videoNames: [String]
    private var videoType: String
    private var playerItems: [AVPlayerItem] = []
    
    init(videoNames: [String], videoType: String) {
        self.videoNames = videoNames
        self.videoType = videoType
        
        prepareQueue()
    }
    
    private func prepareQueue() {
        guard !videoNames.isEmpty else { return }
        player.removeAllItems()
        playerItems = []
        
        // Remove any existing observers to prevent duplicates
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: nil)
        
        for name in videoNames {
            if let url = Bundle.main.url(forResource: name, withExtension: videoType) {
                let item = AVPlayerItem(url: url)
                playerItems.append(item)
                player.insert(item, after: nil)
                
                // Observe each item to restart queue when it ends
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(handlePlaybackEnd(_:)),
                    name: .AVPlayerItemDidPlayToEndTime,
                    object: item
                )
            } else {
                print("❌ Error: Could not find file \(name).\(videoType) in bundle.")
            }
        }
        
        player.actionAtItemEnd = .advance
    }
    
    @objc private func handlePlaybackEnd(_ notification: Notification) {
        restartQueue()
    }
    
    private func restartQueue() {
        player.removeAllItems()
        for item in playerItems {
            player.insert(item, after: nil)
        }
        player.play()
    }
    
    deinit {
        // Clean up observers when VideoPlayerManager is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
}
  
