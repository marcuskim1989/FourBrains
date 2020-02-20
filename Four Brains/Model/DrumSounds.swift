//
//  DrumSounds.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/6/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit

class DrumSounds {
    
    let drums = AKMIDISampler()
    
    var currentBPM = 60
    var drumSoundsToggleState = true
    
    //var output = AudioKit.output
    
    
    let sequencer = AKAppleSequencer(filename: "4tracks")
    init() {
        
        let rideCymbalFile = try! AKAudioFile(readFileName: "rideCymbalSound.wav")
        let snareDrumFile = try! AKAudioFile(readFileName: "snareDrumSound.wav")
        let bassDrumFile = try! AKAudioFile(readFileName: "bassDrumSound.wav")
        let hiHatFile = try! AKAudioFile(readFileName: "hiHatSound.mp3")
        
        drums.enableMIDI(1000)
        
        do{
        try drums.loadAudioFiles([rideCymbalFile,
                                   snareDrumFile,
                                   bassDrumFile,
                                   hiHatFile])
        
        } catch {
            print("error loading samples to drum object")
        }
        
        
        drums.volume = 1
        sequencer.clearRange(start: AKDuration(beats: 0), duration: AKDuration(beats: 100))
        sequencer.debug()
        sequencer.setGlobalMIDIOutput(drums.midiIn)
        sequencer.enableLooping(AKDuration(beats: 4))
        sequencer.setTempo(Double(currentBPM))
        //AudioKit.output = drums
        //output = drums
        
    }
    /*
    func changeDrumsSoundsToggleState(){
        if drumSoundsToggleState {
            drumSoundsToggleState = false
        } else {
            drumSoundsToggleState = true
        }
    }
    */
    func playDrumSounds() {
        /*
        do {
            try AKSettings.setSession(category: .playAndRecord, with:  AVAudioSession.CategoryOptions.defaultToSpeaker)
                
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord)

            if !AKSettings.headPhonesPlugged {
                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
         }
        }catch {
            print("error in settings.setSession")
        }
         */
        sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 1.0))
        sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 1.0))
        sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 1.0))
        sequencer.tracks[0].add(noteNumber: 60, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 1.0))
    
        if sequencer.isPlaying {
            sequencer.stop()
            sequencer.rewind()
        } else {
            sequencer.play()
        }
        
    }
    
    
    }


