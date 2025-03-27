//
//  SoundManager.swift
//  PanDrop
//
//  Created by Aadish Jain on 23/02/25.
//

import AVFoundation
import MediaPlayer // Import MediaPlayer framework

class SoundManager {
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    private let synthesizer = AVSpeechSynthesizer()
    
    init() {
        configureAudioSession()
        setSystemVolume(to: 1.0) // Set system volume to maximum
    }
    
    func configureAudioSession() {
        do {
            // Configure the audio session
            let audioSession = AVAudioSession.sharedInstance()
            
            // Set the category to playback (overrides silent mode)
            try audioSession.setCategory(.playback, mode: .default, options: [])
            
            // Activate the audio session
            try audioSession.setActive(true)
        } catch {
            print("Error configuring audio session: \(error)")
        }
    }
    
    private func setSystemVolume(to volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
            slider?.value = volume
        }
    }
    
    func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error)")
        }
    }
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
