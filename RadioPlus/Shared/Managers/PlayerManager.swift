//
//  PlayerManager.swift
//  RadioPlus
//
//  Created by Derouiche Elyes on 21/12/2022.
//

import Foundation
import AVFoundation


class PlayerManager: ObservableObject {
    
    var player: AVPlayer?
    
    @Published
    var currentlyPlaying: String?
    
    func play(identifier: String, url: String) -> Bool {
        if let url = URL(string: url) {
            player = .init(url: url)
            player?.play()
            currentlyPlaying = identifier
            return true
        }
        return false
    }
    
    func stop() {
        player?.pause()
        player = nil
        currentlyPlaying = nil
    }
}
