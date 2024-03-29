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
    
    private var timeSignatureTop: Int = 4
    private let downbeatNoteNumber: MIDINoteNumber = MIDINoteNumber(16)
    private let beatNoteNumber: MIDINoteNumber = MIDINoteNumber(7)
    private let beatNoteVelocity: Double = 100.0
    private var currentBeat: Int = 0
    private var callbackInst: CallbackInstrument = CallbackInstrument()
    
    private let shaker: Shaker = Shaker()
    private var metronomeSequencer: Sequencer = Sequencer()
    private let homeScreenViewController: HomeScreenViewController!
    private var metronomeToggleState: Bool = true
    private var subdivision: Int = 4
    private var divisor: Int = 1
    private let fader: Fader
    
    init(homeScreenViewController: HomeScreenViewController) {
        
        fader = Fader(shaker)
        self.homeScreenViewController = homeScreenViewController
        
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
        
        
        metronomeSequencer.tempo = Double(homeScreenViewController.getCurrentBPM())
        print("initial tempo: \(metronomeSequencer.tempo)")
    }
    
    public func getFader() -> Fader {
        return fader
    }
    
    public func getCallbackInstrument() -> CallbackInstrument {
        return callbackInst
    }
    
    public func getMetronomeSequencer() -> Sequencer {
        return metronomeSequencer
    }
    
    func updateSequences() {
        var track: SequencerTrack = metronomeSequencer.tracks.first! // what is this sequencer and what is its tracks property and what is tracks' first property
        
        track.length = Double(timeSignatureTop)
        
        track.clear()
        
        // add the downbeat at position 0 (the very first position)
        track.sequence.add(noteNumber: downbeatNoteNumber, position: 0.0, duration: 0.4)
        
        let vel: MIDIVelocity = MIDIVelocity(Int(beatNoteVelocity))
        
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
        
        var cardWhiteOutCounter: Int = (self.currentBeat / self.divisor) + 1
        var cardFadeClearCounter: Int = (self.currentBeat / self.divisor) + 1
        
        let deadlineTime: DispatchTime = DispatchTime.now() + (60 / metronomeSequencer.tempo) / 10.0
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            for _ in 1...4 {
                
                let beatCardToBeHighlighted: UIView? =
                self.homeScreenViewController
                    .view
                    .viewWithTag(cardWhiteOutCounter)
                
                beatCardToBeHighlighted?.backgroundColor = .white
                
                cardWhiteOutCounter += 4
                
            }
            
            UIView.animate(withDuration: (60 / self.metronomeSequencer.tempo)) {
                for _ in 1...4 {
                    
                    let cardToFadeClear: UIView? = self.homeScreenViewController.view.viewWithTag(cardFadeClearCounter)
                    cardToFadeClear?.backgroundColor = .clear
                    
                    cardFadeClearCounter += 4
                    
                }
                
            }
            print("showHighlightBar executed")
        }
    }
    
    func changeMetronomeToggleState() -> Bool {
        
        metronomeToggleState.toggle()
        
        print("metronomeToggleState inside changeMetronomeToggleState: \(!metronomeToggleState)")
        return metronomeToggleState
    }
    
    func playMetronome() {
        
        if metronomeToggleState {
            print("metronomeToggleState inside if inside playMetronome(): \(metronomeToggleState)")
            
            updateSequences()
            metronomeSequencer.play()
            
        }
    }
    
    
    func stopMetronome() {
        print("metronomeToggleState inside if inside stopMetronome(): \(metronomeToggleState)")
        metronomeSequencer.stop()
        metronomeSequencer.rewind()
    }
    
    func setTempo(subdivision: Int, currentBPM: Int) {
        
        divisor = subdivision / 4
        
        if divisor == 1 {
            metronomeSequencer.tempo = Double(currentBPM)
            timeSignatureTop = 4
        } else if divisor == 2 {
            metronomeSequencer.tempo = Double(currentBPM * 2)
            timeSignatureTop = 8
        } else if divisor == 4 {
            metronomeSequencer.tempo = Double(currentBPM * 4)
            timeSignatureTop = 16
        }
    }
    
}
