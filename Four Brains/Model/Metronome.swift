//
//  Metronome.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/6/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import UIKit
import AudioKit

class Metronome {
    
    var isPlaying = false
    var tempo: BPM = 60
    var timeSignatureTop: Int = 4
    var downbeatNoteNumber = MIDINoteNumber(16)
    var beatNoteNumber = MIDINoteNumber(7)
    var beatNoteVelocity = 100.0
    var currentBeat = 0
    var callbackInst = CallbackInstrument()
    
    let shaker = Shaker()
    var metronomeSequencer = Sequencer()
    var homeScreenViewController: HomeScreenViewController!
    var metronomeToggleState = true
    var subdivision = 4
    var divisor = 1
    var eighthNoteSubtractionCounter = 0
    var sixteenthNoteSubtractionCounter = 0
    let fader: Fader
    
    init(homeScreenViewController: HomeScreenViewController) {
        
        fader = Fader(shaker)
        
        let _ = metronomeSequencer.addTrack(for: shaker)
        
        callbackInst = CallbackInstrument(midiCallback: { (_, beat, _) in
            self.currentBeat = Int(beat)
            
            if self.currentBeat % self.divisor == 0 {
                self.highlightBeatCards()
                print("highlightBeatCards() called, currentBeat is \(self.currentBeat)")
            }
              
        })
        
        let _ = metronomeSequencer.addTrack(for: callbackInst)
        updateSequences()
        
        self.homeScreenViewController = homeScreenViewController
        metronomeSequencer.tempo = tempo
        print("initial tempo: \(metronomeSequencer.tempo)")
    }
            
            

    func updateSequences() {
        var track = metronomeSequencer.tracks.first! // what is this sequencer and what is its tracks property and what is tracks' first property

        track.length = Double(timeSignatureTop)

        track.clear()
        
        // add the downbeat at position 0 (the very first position)
        track.sequence.add(noteNumber: downbeatNoteNumber, position: 0.0, duration: 0.4)
        
        let vel = MIDIVelocity(Int(beatNoteVelocity))
        
        // for every subsequent beat, starting from position 1 (2nd beat), add a beat
        for beat in 1 ..< timeSignatureTop {
            track.sequence.add(noteNumber: beatNoteNumber, velocity: vel, position: Double(beat), duration: 0.1)
        }

        track = metronomeSequencer.tracks[1]
        
        track.length = Double(timeSignatureTop)
        
        track.clear()
        for beat in 0 ..< timeSignatureTop {
            track.sequence.add(noteNumber: MIDINoteNumber(beat), position: Double(beat), duration: 0.1)
        }

    }
    
    
    func highlightBeatCards() {
        
        var cardWhiteOutCounter = self.currentBeat/self.divisor + 1
        var cardFadeClearCounter = self.currentBeat/self.divisor + 1
        
        let deadlineTime = DispatchTime.now() + (60/metronomeSequencer.tempo) / 10.0
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                for _ in 0...3 {

                    let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardWhiteOutCounter)
                    beatCardToBeHighlighted?.backgroundColor = .white
                
                    cardWhiteOutCounter += 4
                
            }
            
            UIView.animate(withDuration: (60/self.metronomeSequencer.tempo)){
                for _ in 0...3 {
                    
                    let beatCardToFadeClear = self.homeScreenViewController.view.viewWithTag(cardFadeClearCounter)
                    beatCardToFadeClear?.backgroundColor = .clear
                    
                    cardFadeClearCounter += 4
                
                }
                
            }
            print("showHighlightBar executed")
        }
    }
    
    func changeMetronomeToggleState() -> Bool{
        if metronomeToggleState {
            metronomeToggleState = false
        } else {
            metronomeToggleState = true
        }
        
        print("metronomeToggleState inside changeMetronomeToggleState: \(metronomeToggleState)")
        return metronomeToggleState
    }
    
    
    
    func playMetronome(){
        
        if metronomeToggleState{
            print("metronomeToggleState inside if inside playMetronome(): \(metronomeToggleState)")
            
            updateSequences()
            metronomeSequencer.play()

       }
    }
    
    
        func stopMetronome() {
            print("metronomeToggleState inside if inside stopMetronome(): \(metronomeToggleState)")
            metronomeSequencer.stop()
            metronomeSequencer.rewind()
            resetHighlightBar()
        }
        
        
    
    
    func changeSubdivision(subdivision: Int) {
        
        divisor = subdivision/4
        
        if divisor == 1 {
            metronomeSequencer.tempo = Double(homeScreenViewController.currentBPM)
            timeSignatureTop = 4
        } else if divisor == 2 {
            metronomeSequencer.tempo = Double(homeScreenViewController.currentBPM * 2)
            timeSignatureTop = 8
        } else if divisor == 4 {
            metronomeSequencer.tempo = Double(homeScreenViewController.currentBPM * 4)
            timeSignatureTop = 16
        }
    }
    
    func resetHighlightBar() {
        eighthNoteSubtractionCounter = 0
        sixteenthNoteSubtractionCounter = 0
    }
    
}


