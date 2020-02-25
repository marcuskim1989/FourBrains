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
   
    var rideNoteSequence: [Int] = [0]
    var snareNoteSequence: [Int] = [0]
    var bassNoteSequence: [Int] = [0]
    var hiHatNoteSequence: [Int] = [0]
    
    var rideNoteArray: [()] = [()]
    
    var currentBPM = 60
    //var drumSoundsToggleState = true
    
    let sequencer = AKAppleSequencer(filename: "4tracks")
    init() {
        
        let rideCymbalFile = try! AKAudioFile(readFileName: "open_hi_hat_A#1.wav")
        let snareDrumFile = try! AKAudioFile(readFileName: "snare_D1.wav")
        let bassDrumFile = try! AKAudioFile(readFileName: "bass_drum_C1.wav")
        let hiHatFile = try! AKAudioFile(readFileName: "closed_hi_hat_F#1.wav")
        
        rideNoteArray[0] = sequencer.tracks[0].add(noteNumber: 1, velocity: 0, position: AKDuration(beats: 0), duration: AKDuration(beats: 0.0))
        
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
    
    //MARK: Parse  from wholeBeat
    func parseNoteSequence(wholeBeat: WholeBeat) {
        
        rideNoteSequence = [0]
        snareNoteSequence = [0]
        bassNoteSequence = [0]
        hiHatNoteSequence = [0]
        
        // Parse ride sequence
        for beatCardCounter in Range(0...3) {
            
            for note in Range(0...3) {
            
                if beatCardCounter == 0 && note == 0{
                    rideNoteSequence[0] = wholeBeat.ridePattern[beatCardCounter].beatCardNoteSequence[note]
                } else {
                    rideNoteSequence.append(wholeBeat.ridePattern[beatCardCounter].beatCardNoteSequence[note])
                }
            
            }
            
        }
        print("Ride note sequence: \(rideNoteSequence)")
        
        // Parse snare sequence
        for beatCardCounter in Range(0...3) {
            
            for note in Range(0...3) {
            
                if beatCardCounter == 0 && note == 0{
                    snareNoteSequence[0] = wholeBeat.snarePattern[beatCardCounter].beatCardNoteSequence[note]
                } else {
                    snareNoteSequence.append(wholeBeat.snarePattern[beatCardCounter].beatCardNoteSequence[note])
                }
            
            }
            
        }
        print("Snare note sequence: \(snareNoteSequence)")
        
        // Parse bass sequence
        for beatCardCounter in Range(0...3) {
            
            for note in Range(0...3) {
            
                if beatCardCounter == 0 && note == 0{
                    bassNoteSequence[0] = wholeBeat.bassPattern[beatCardCounter].beatCardNoteSequence[note]
                } else {
                    bassNoteSequence.append(wholeBeat.bassPattern[beatCardCounter].beatCardNoteSequence[note])
                }
            
            }
            
        }
        print("Bass note sequence: \(bassNoteSequence)")
        
        // Parse hi hat sequence
        for beatCardCounter in Range(0...3) {
            
            for note in Range(0...3) {
            
                if beatCardCounter == 0 && note == 0{
                    hiHatNoteSequence[0] = wholeBeat.hiHatPattern[beatCardCounter].beatCardNoteSequence[note]
                } else {
                    hiHatNoteSequence.append(wholeBeat.hiHatPattern[beatCardCounter].beatCardNoteSequence[note])
                }
            
            }
            
        }
        print("Hi-Hat: \(hiHatNoteSequence)")
        
        
    }
    
    func assignDrumSounds () {
        
        //MARK: Ride cymbal note assignment
        for note in Range(0 ... 15) {
            
            let position = ((Double(note) + 1.0)/4.0) - 0.25
            
                let newNote = sequencer.tracks[0].add(noteNumber: 34, velocity: 127, position: AKDuration(beats: position), duration: AKDuration(beats: 1.0))
                if note == 0 {
                    rideNoteArray[0] = newNote
                } else {
                    rideNoteArray.append(newNote)
                }
            
            print(position)
        }
        
        /*
        //MARK: Snare drum note assignment
        for note in Range(0 ... 15) {
            
            let position = ((Double(note) + 1.0)/4.0) - 0.25
            
                let newNote = sequencer.tracks[1].add(noteNumber: 26, velocity: 127, position: AKDuration(beats: position), duration: AKDuration(beats: 1.0))
                if note == 0 {
                    rideNoteArray[0] = newNote
                } else {
                    rideNoteArray.append(newNote)
                }
            
            print(position)
        }
        
        //MARK: Bass drum note assignment
        for note in Range(0 ... 15) {
            
            let position = ((Double(note) + 1.0)/4.0) - 0.25
            
                let newNote = sequencer.tracks[2].add(noteNumber: 24, velocity: 127, position: AKDuration(beats: position), duration: AKDuration(beats: 1.0))
                if note == 0 {
                    rideNoteArray[0] = newNote
                } else {
                    rideNoteArray.append(newNote)
                }
            
            print(position)
        }
        
        //MARK: Hi-Hat note assignment
        for note in Range(0 ... 15) {
            
            let position = ((Double(note) + 1.0)/4.0) - 0.25
            
                let newNote = sequencer.tracks[3].add(noteNumber: 30, velocity: 127, position: AKDuration(beats: position), duration: AKDuration(beats: 1.0))
                if note == 0 {
                    rideNoteArray[0] = newNote
                } else {
                    rideNoteArray.append(newNote)
                }
            
            print(position)
        }
    */
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
        
        if sequencer.isPlaying {
            sequencer.stop()
            //sequencer.clearRange(start: AKDuration(beats: 0), duration: AKDuration(beats: 100))
            sequencer.rewind()
        } else {
            sequencer.play()
        }
        
    }
    
    }


