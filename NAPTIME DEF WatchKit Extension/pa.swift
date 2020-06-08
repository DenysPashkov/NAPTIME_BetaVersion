//
//  pa.swift
//  SOUND WatchKit Extension
//
//  Created by Vito De bellis on 28/03/2020.
//  Copyright © 2020 Vito De bellis. All rights reserved.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

//For play the sound
func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
          audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch{
            print("Can't find file audio")
        }
    }
}

func stopMusic(){
	audioPlayer?.stop()
}

