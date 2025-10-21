//
//  AudioManager.swift
//  Yahtzee
//
//  This file defines the `AudioManager` class, responsible for handling
//  sound playback and mute state throughout the Yahtzee game.
//
//  Created by 陳嘉國
//


import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?
    
    @Published var isMuted: Bool = false {
        didSet {
            audioPlayer?.volume = isMuted ? 0 : 1
        }
    }
    
    func toggleMute() {
        isMuted.toggle()
    }
    
    
    func playSound(sound: String, type: String) {
        guard !isMuted else { return }
        
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = isMuted ? 0 : 1
                audioPlayer?.play()
            } catch {
                print("ERROR: Could not find and play the sound file!")
            }
        }
    }
    
    func playSound(sound: String, type: String, duration: Double) {
        guard !isMuted else { return }
        
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = isMuted ? 0 : 1
                audioPlayer?.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                    self.audioPlayer?.stop()
                }
                
            } catch {
                print("ERROR: Could not find and stop the sound file!")
            }
        }
    }
    
}

