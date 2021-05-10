//
//  PlaybackPresenter.swift
//  Spotifnd
//
//  Created by Aldo Ponce de la Cruz on 07/05/21.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayerDataSoruce: AnyObject {
    var songName: String? { get }
    var subtitle: String? { get }
    var imageURL: URL? { get }
    var trackToPass: AudioTrack? { get }
}

final class PlaybackPresenter{
    
    static let shared = PlaybackPresenter()
    
    private var track: AudioTrack?
    private var tracks = [AudioTrack]()
    
    var index = 0
    
    var currentTrack: AudioTrack?{
        if let track = track, tracks.isEmpty{
            return track
        } else if let player = self.playerQueue, !tracks.isEmpty{
            return tracks[index]
            }
        return nil
    }
    
    var playerVC: PlayerViewController?
    
    var player: AVPlayer?
    var playerQueue: AVQueuePlayer?
    
    func startPlayback(from viewController: UIViewController, track: AudioTrack){
        do{
        try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch{
            print("error")
        }
        guard let url = URL(string: track.preview_url ?? "") else {
            return
        }
        player = AVPlayer(url: url)
        player?.allowsExternalPlayback = false
        player?.volume = 0.5
        
        self.track = track
        self.tracks = []
        let vc = PlayerViewController()
        vc.title = track.name
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc) ,animated: true) { [weak self]  in
            self?.player?.play()
        }
        self.playerVC = vc
    }
    
    func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]){
        self.tracks = tracks
        self.track = nil
        
        do{
        try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch{
            print("error")
        }
        
        self.playerQueue = AVQueuePlayer(items: tracks.compactMap({
            guard let url = URL(string: $0.preview_url ?? "") else{
                return nil
            }
            return AVPlayerItem(url: url)
            
        }))
        self.playerQueue?.volume = 0.5
        self.playerQueue?.play()
        
        let vc = PlayerViewController()
        vc.dataSource = self
        vc.delegate = self
        viewController.present(UINavigationController(rootViewController: vc),animated: true,completion: nil)
        self.playerVC = vc
    }

    
}

extension PlaybackPresenter: PlayerViewControllerDelegate{
    func didTapBackward() {
        if tracks.isEmpty{
            player?.pause()
            player?.play()
        } else if let firstItem = playerQueue?.items().first{
            playerQueue?.pause()
            playerQueue?.removeAllItems()
            playerQueue = AVQueuePlayer(items: [firstItem])
            playerQueue?.play()
            playerQueue?.volume = 50
            
        }
    }
    
    func didTapForward() {
        if tracks.isEmpty{
            player?.pause()
        } else  if let player = playerQueue {
            player.advanceToNextItem()
            index += 1
            playerVC?.refreshUI()
        }
    }
    
    func didTapPlayPause() {
        if let player = player{
            if player.timeControlStatus == .playing{
                player.pause()
            } else if player.timeControlStatus == .paused{
                player.play()
            }
        }
        else if let player = playerQueue{
            if player.timeControlStatus == .playing{
                player.pause()
            } else if player.timeControlStatus == .paused{
                player.play()
            }
        }
    }
    
    func didSlideSlider(_ value: Float) {
        player?.volume = value
    }
}

extension PlaybackPresenter: PlayerDataSoruce{
    var songName: String? {
        return currentTrack?.name
    }
    
    var subtitle: String? {
        return currentTrack?.artists.first?.name
    }
    
    var imageURL: URL? {
        return URL(string: currentTrack?.album?.images.first?.url ?? "")
    }
    
    var trackToPass: AudioTrack? {
        return currentTrack
    }
    
}
