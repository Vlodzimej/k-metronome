//
//  ViewController.swift
//  k-metronome
//
//  Created by Владимир Амелькин on 14.01.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var tempoField: UITextField!
    @IBOutlet var button: UIButton!
    
    private var timer: Timer?
    private var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    private var tempo: Float = 120
    private var isLaunching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tempoField.text = String(tempo)
        initAudioPlayer()
    }
    
    @objc func tap() {
        print("TAP " + String(tempo))
        
        //guard let audioPlayer = audioPlayer else { return }
        playSound()
    }
    
    @IBAction func startButtonHandler() {
        isLaunching ? stopTimer() : startTimer()
        updateButton()
    }

    private func getTimeInterval(with tempo: Float) -> TimeInterval {
        let newTempo = 60 / tempo
        return TimeInterval(newTempo)
    }
    
    private func startTimer() {
        let tempo = Float(tempoField.text!) ?? 120
        let timeInterval = getTimeInterval(with: tempo)
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(ViewController.tap), userInfo: nil, repeats: true)
        isLaunching = true
    }
    
    private func stopTimer() {
        guard let timer = timer else {
            return
        }
        
        timer.invalidate()
        isLaunching = false
    }
    
    private func updateButton() {
        button.setTitle(isLaunching ? "Stop" : "Start", for: .normal)
    }
    
    private func initAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "sound1", ofType:"mp3") else {
            return
        }
        
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func playSound() {
//        guard let audioPlayer = audioPlayer else {
//            return
//        }
        
        audioPlayer.play()
    }
}

