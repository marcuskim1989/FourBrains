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
   
    var rideCymbalPattern: [Int]?
    var snareDrumPattern: [Int]?
    var bassDrumPattern: [Int]?
    var hiHatPattern: [Int]?
    
    
    var currentBPM = 60
    //var drumSoundsToggleState = true
    
    let sequencer = AKAppleSequencer(filename: "4tracks")
    init() {
        
        let rideCymbalFile = try! AKAudioFile(readFileName: "open_hi_hat_A#1.wav")
        let snareDrumFile = try! AKAudioFile(readFileName: "snare_D1.wav")
        let bassDrumFile = try! AKAudioFile(readFileName: "bass_drum_C1.wav")
        let hiHatFile = try! AKAudioFile(readFileName: "closed_hi_hat_F#1.wav")
        
        do{
        try drums.loadAudioFiles([rideCymbalFile,
                                   snareDrumFile,
                                   bassDrumFile,
                                   hiHatFile])
        
        } catch {
            print("error loading samples to drum object")
        }
        
        //drums.enableMIDI(AudioKit.midi.client, name: "4tracks")
        
        sequencer.clearRange(start: AKDuration(beats: 0), duration: AKDuration(beats: 100))
        sequencer.debug()
        sequencer.setGlobalMIDIOutput(drums.midiIn)
        sequencer.enableLooping(AKDuration(beats: 4))
        sequencer.setTempo(Double(currentBPM))
       
        
    }
   
    func playDrumSounds() {
        
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
        
        var noteArray: [()] = [sequencer.tracks[0].add(noteNumber: 1, velocity: 0, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.0))]
        
        for note in Range(0 ... 15) {
            let position = ((Double(note) + 1.0)/4.0) - 0.25
            
                let newNote = sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: position), duration: AKDuration(beats: 1.0))
                if note == 0 {
                    noteArray[0] = newNote
                } else {
                    noteArray.append(newNote)
                }
            
            print(position)
        }
        
        /*
        //ride cymbal
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 1.0)) //1
        //sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 0.25), duration: AKDuration(beats: 1.0)) //e
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 0.5), duration: AKDuration(beats: 1.0)) //&
        //sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 0.75), duration: AKDuration(beats: 1.0))//a
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 1.0))//2
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 1.25), duration: AKDuration(beats: 1.0))//e
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 1.5), duration: AKDuration(beats: 1.0))//&
        //sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 1.75), duration: AKDuration(beats: 1.0))//a
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 1.0))//3
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 2.25), duration: AKDuration(beats: 1.0))//e
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 2.5), duration: AKDuration(beats: 1.0))//&
        //sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 2.75), duration: AKDuration(beats: 1.0))//a
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 1.0))//4
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 3.25), duration: AKDuration(beats: 1.0))//e
        sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 3.5), duration: AKDuration(beats: 1.0))//&
        //sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: 3.75), duration: AKDuration(beats: 1.0))//a
        
        //snare drum
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 1.0)) //1
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 0.25), duration: AKDuration(beats: 1.0)) //e
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 0.5), duration: AKDuration(beats: 1.0)) //&
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 0.75), duration: AKDuration(beats: 1.0))//a
        sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 1.0))//2
        sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 1.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 1.5), duration: AKDuration(beats: 1.0))//&
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 1.75), duration: AKDuration(beats: 1.0))//a
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 1.0))//3
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 2.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 2.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 2.75), duration: AKDuration(beats: 1.0))//a
        sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 1.0))//4
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 3.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 3.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: 3.75), duration: AKDuration(beats: 1.0))//a
        
        //bass drum
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 1.0)) //1
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 0.25), duration: AKDuration(beats: 1.0)) //e
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 0.5), duration: AKDuration(beats: 1.0)) //&
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 0.75), duration: AKDuration(beats: 1.0))//a
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 1.0))//2
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 1.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 1.5), duration: AKDuration(beats: 1.0))//&
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 1.75), duration: AKDuration(beats: 1.0))//a
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 1.0))//3
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 2.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 2.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 2.75), duration: AKDuration(beats: 1.0))//a
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 1.0))//4
        //sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 3.25), duration: AKDuration(beats: 1.0))//e
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 3.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: 3.75), duration: AKDuration(beats: 1.0))//a
        
        //hi hat splash
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 0), duration: AKDuration(beats: 1.0)) //1
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 0.25), duration: AKDuration(beats: 1.0)) //e
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 0.5), duration: AKDuration(beats: 1.0)) //&
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 0.75), duration: AKDuration(beats: 1.0))//a
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 1), duration: AKDuration(beats: 1.0))//2
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 1.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 1.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 1.75), duration: AKDuration(beats: 1.0))//a
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 2), duration: AKDuration(beats: 1.0))//3
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 2.25), duration: AKDuration(beats: 1.0))//e
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 2.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 2.75), duration: AKDuration(beats: 1.0))//a
        //sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 3), duration: AKDuration(beats: 1.0))//4
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 3.25), duration: AKDuration(beats: 1.0))//e
        //`sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 3.5), duration: AKDuration(beats: 1.0))//&
        sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: 3.75), duration: AKDuration(beats: 1.0))//a
        */
      
        if sequencer.isPlaying {
            sequencer.stop()
            //sequencer.clearRange(start: AKDuration(beats: 0), duration: AKDuration(beats: 100))
            sequencer.rewind()
        } else {
            sequencer.play()
        }
        
    }
    
    
    }


