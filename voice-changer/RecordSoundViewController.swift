//
//  RecordSoundViewController.swift
//  voice-changer
//
//  Created by Rohit Rajput on 06/02/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import AVFoundation
import UIKit

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var startRecordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
 
    @IBAction func startRecordingButtonDidPress(_ sender: Any) {
        setupView(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(fileURLWithPath: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder  = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.isMeteringEnabled = true
        
        // setting this view recorder as delegate to the AVAudoiRecorderDelegate
        audioRecorder.delegate = self
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
 
    func setupView(isRecording: Bool) {
        if isRecording {
            startRecordingButton.isEnabled = false
            stopRecordingButton.isEnabled = true
            recordingLabel.text = "Recording in progress..."
        } else {
            startRecordingButton.isEnabled = true
            stopRecordingButton.isEnabled = false
            recordingLabel.text = "Tap to record"
        }
    }
    
    @IBAction func stopRecordingButtonDidPress(_ sender: Any) {
        setupView(isRecording: false)
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlaybackVC" {
            let playBackVC = segue.destination as! PlaybackViewController
            let recordedAudioURL = sender as! URL
            playBackVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "toPlaybackVC", sender: audioRecorder.url)
        } else {
            print("Recording failed")
        }
    }
}

