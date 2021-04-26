//
//  DrumSounds.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/6/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit
import AVFoundation
import Combine

class DrumSounds {
    let drums = MIDISampler(name: "drums")
    let sequencer = AppleSequencer(filename: "4tracks")
    
    
    var rideNoteSequence: [Int] = [0]
    var snareNoteSequence: [Int] = [0]
    var bassNoteSequence: [Int] = [0]
    var hiHatNoteSequence: [Int] = [0]
    
    var rideNoteArray: [()] = [()]
    var snareNoteArray: [()] = [()]
    var bassNoteArray: [()] = [()]
    var hiHatNoteArray: [()] = [()]
    
    var currentBPM = 60
    //var drumSoundsToggleState = true
    
    var mute: Mute!
    
    init(mute: Mute) {
        
     
        self.mute = mute
        
        let rideCymbalFile = try! AVAudioFile(forReading: URL(resolvingAliasFileAt: Bundle.main.url(forResource: K.DRUMSOUNDFILENAMES.RIDE_FILE_NAME, withExtension: "wav")!))
        print("\(rideCymbalFile) is not empty")
        let snareDrumFile = try! AVAudioFile(forReading: URL(resolvingAliasFileAt: Bundle.main.url(forResource: K.DRUMSOUNDFILENAMES.SNARE_FILE_NAME, withExtension: "wav")!))
        let bassDrumFile = try! AVAudioFile(forReading: URL(resolvingAliasFileAt: Bundle.main.url(forResource: K.DRUMSOUNDFILENAMES.BASS_FILE_NAME, withExtension: "wav")!))
        let hiHatFile = try! AVAudioFile(forReading: URL(resolvingAliasFileAt: Bundle.main.url(forResource: K.DRUMSOUNDFILENAMES.HI_HAT_FILE_NAME, withExtension: "wav")!))
        
       
        
        do{
        try drums.loadAudioFiles([rideCymbalFile,
                                   snareDrumFile,
                                   bassDrumFile,
                                   hiHatFile])
        
        } catch {
            print("error loading samples to drum object")
        }
        
        sequencer.clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
        sequencer.debug()
        sequencer.setGlobalMIDIOutput(drums.midiIn)
        sequencer.enableLooping(Duration(beats: 4))
        sequencer.setTempo(Double(currentBPM))
       
    }
    
    //MARK: Parse from wholeBeat
    func parseNoteSequence(wholeBeat: WholeBeat) {
        
        rideNoteSequence = [0]
        snareNoteSequence = [0]
        bassNoteSequence = [0]
        hiHatNoteSequence = [0]
        
        // MARK: Parse ride sequence
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
        
        // MARK: Parse snare sequence
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
        
        // MARK: Parse bass sequence
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
        
        //MARK: Parse hi hat sequence
        for beatCardCounter in Range(0...3) {
            for note in Range(0...3) {
                if beatCardCounter == 0 && note == 0{
                    hiHatNoteSequence[0] = wholeBeat.hiHatPattern[beatCardCounter].beatCardNoteSequence[note]
                } else {
                    hiHatNoteSequence.append(wholeBeat.hiHatPattern[beatCardCounter].beatCardNoteSequence[note])
                }
            }
        }
        print("Hi-Hat note sequence: \(hiHatNoteSequence)")
        
        print("parsenNoteSequence() called")
        
        assignDrumSounds()
        
    }
    
    func assignDrumSounds() {
        sequencer.clearRange(start: Duration(beats: 0), duration: Duration(beats: 100))
        
        //MARK: Ride cymbal note assignment
        if !mute.rideMuteState{
            for note in Range(0...15) {
                let position = ((Double(note) + 1.0)/4.0) - 0.25
                if rideNoteSequence[note] == 1 {
                    sequencer.tracks[0].add(
                        noteNumber: 34,
                        velocity: 200,
                        position: Duration(beats: position),
                        duration: Duration(beats: 0.25))
              
                    print("Ride: \(position)")
                
            }
        }
            
        }
        
        //MARK: Snare drum note assignment
        
        if !mute.snareMuteState {
            for note in Range(0...15) {
                let position = ((Double(note) + 1.0)/4.0) - 0.25
                if snareNoteSequence[note] == 1 {
                    sequencer.tracks[1].add(
                        noteNumber: 26,
                        velocity: 200,
                        position: Duration(beats: position),
                        duration: Duration(beats: 0.25))
               
                print("Snare: \(position)")
                }
            }
        }
        
        //MARK: Bass drum note assignment
        
        if !mute.bassMuteState {
            for note in Range(0 ... 15) {
                let position = ((Double(note) + 1.0)/4.0) - 0.25
                if bassNoteSequence[note] == 1 {
                    sequencer.tracks[2].add(
                        noteNumber: 24,
                        velocity: 200,
                        position: Duration(beats: position),
                        duration: Duration(beats: 0.25))
              
                print("Bass: \(position)")
                }
            }
        }
         
        //MARK: Hi-Hat note assignment
        if !mute.hiHatMuteState{
            for note in Range(0 ... 15) {
                let position = ((Double(note) + 1.0)/4.0) - 0.25
                if hiHatNoteSequence[note] == 1 {
                    sequencer.tracks[3].add(
                        noteNumber: 30,
                        velocity: 200,
                        position: Duration(beats: position),
                        duration: Duration(beats: 0.25))
                
                print("Hi Hat: \(position)")
                }
            }
        }
        
        print("assignDrumSounds() called")
         
    }
    func playDrumSounds() {
        
//        do {
//            try Settings.setSession(category: .playAndRecord, with:  AVAudioSession.CategoryOptions.defaultToSpeaker)
//
//            let session = AVAudioSession.sharedInstance()
//            try session.setCategory(AVAudioSession.Category.playAndRecord)
//
//            if !Settings.headPhonesPlugged {
//                try session.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
//         }
//        }catch {
//            print("error in settings.setSession")
//        }
        
        
        sequencer.play()
         
        }
    
    func stopDrumsSounds() {
        sequencer.stop()
        sequencer.rewind()
    
    }
    }


