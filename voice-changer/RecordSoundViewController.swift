//
//  RecordSoundViewController.swift
//  voice-changer
//
//  Created by Rohit Rajput on 06/02/18.
//  Copyright © 2018 Rohit Rajput. All rights reserved.
//

import AVFoundation
import UIKit

class RecordSoundViewController: UIViewController {

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
        startRecordingButton.isEnabled = false
        stopRecordingButton.isEnabled = true
        recordingLabel.text = "Recording in progress..."
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(fileURLWithPath: pathArray.joined(separator: "/"))
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
//        try! session.setActive(true)
        
        try! audioRecorder  = AVAudioRecorder(url: filePath, settings: [:])
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
 
    
    @IBAction func stopRecordingButtonDidPress(_ sender: Any) {
        startRecordingButton.isEnabled = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
}

