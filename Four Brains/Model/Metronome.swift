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
    var downbeatNoteNumber = MIDINoteNumber(6)
    var beatNoteNumber = MIDINoteNumber(10)
    var beatNoteVelocity = 100.0
    var timeSignatureTop: Int = 4
    var currentBeat = 0
    var callbackInst = CallbackInstrument()
    
    var sequencer = Sequencer()
    var homeScreenViewController: HomeScreenViewController!
    var metronomeToggleState = true
    var subdivision = 4
    var divisor = 1
    var beepCounter = 0
    var eighthNoteSubtractionCounter = 0
    var sixteenthNoteSubtractionCounter = 0
    
    init(homeScreenViewController: HomeScreenViewController) {
        
        self.homeScreenViewController = homeScreenViewController
        print("initial tempo: \(sequencer.tempo)")
        
        
            
            if self.beepCounter >= self.subdivision {
                self.beepCounter = 0
            }
            
            
//            print("currentBeat is \(self.sequencer.currentBeat)")
            
            //when the divisor is 1, highlight bar will shine every 1 beat. when the divisor is 2, the highlight bar will shine every 2 beats. When the divisor is 4, the highlight bar will shine every 4 beats. 
            
            print("beepCounter is \(self.beepCounter), divisor is \(self.divisor), before main if inside metronome.callback")
            
            if self.beepCounter % self.divisor == 0 {
            
                //self.highlightBeatCards()
                
                }
            
            self.beepCounter += 1
            
            print("call back executed")
            }
            
            

    func updateSequences() {
        var track = sequencer.tracks.first! // what is this sequencer and what is its tracks property and what is tracks' first property

        track.length = Double(timeSignatureTop)

        track.clear()
        
        // add the downbeat at position 0 (the very first position)
        track.sequence.add(noteNumber: downbeatNoteNumber, position: 0.0, duration: 0.4)
        
        let vel = MIDIVelocity(Int(beatNoteVelocity))
        
        // for every subsequent beat, starting from position 1 (2nd beat), add a beat
        for beat in 1 ..< timeSignatureTop {
            track.sequence.add(noteNumber: beatNoteNumber, velocity: vel, position: Double(beat), duration: 0.1)
        }

        track = sequencer.tracks[1]
        
        track.length = Double(timeSignatureTop)
        
        track.clear()
        for beat in 0 ..< timeSignatureTop {
            track.sequence.add(noteNumber: MIDINoteNumber(beat), position: Double(beat), duration: 0.1)
        }

    }
    
    
    func highlightBeatCards() {
        
        var cardCounterWhiteOut = self.beepCounter + 1
        var cardCounterFadeClear = self.beepCounter + 1
        
        // let deadlineTime = DispatchTime.now() + (60/metronome.tempo) / 10.0
        DispatchQueue.main.sync {
            for _ in 0...3 {
                if self.divisor == 1{
                    let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterWhiteOut)
                    beatCardToBeHighlighted?.backgroundColor = .white
                    print("beepCounter is \(self.beepCounter), cardCounterWhiteOut is \(cardCounterWhiteOut)")
                }else if self.divisor == 2 {
                    let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterWhiteOut - self.eighthNoteSubtractionCounter)
                    
                    beatCardToBeHighlighted?.backgroundColor = .white
                    print("beepCounter is \(self.beepCounter), cardCounterWhiteOut is \(cardCounterWhiteOut), eightNoteSubtractionCounter is \(self.eighthNoteSubtractionCounter), cardCounterWhiteOut - eightNoteSubtractionCounter is \(cardCounterWhiteOut - self.eighthNoteSubtractionCounter)")
                } else if self.divisor ==  4 {
                    let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterWhiteOut - self.sixteenthNoteSubtractionCounter)
                    
                    beatCardToBeHighlighted?.backgroundColor = .white
                    print("noteCounter is \(self.beepCounter), cardCounterWhiteOut is \(cardCounterWhiteOut), sixteenthNoteSubtractionCounter is \(self.sixteenthNoteSubtractionCounter), cardCounterWhiteOut - sixteenthNoteSubtractionCounter is \(cardCounterWhiteOut - self.sixteenthNoteSubtractionCounter)")
                }
                
                
                cardCounterWhiteOut += 4
                
                
                if cardCounterWhiteOut >= (self.beepCounter + 1)/self.divisor + 24{
                cardCounterWhiteOut = 1
                }
            }
            
            UIView.animate(withDuration: (60/self.sequencer.tempo)){
                for _ in 0...3 {
                    if self.divisor == 1{
                        let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterFadeClear)
                        beatCardToBeHighlighted?.backgroundColor = .clear
                    }else if self.divisor == 2 {
                        let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterFadeClear - self.eighthNoteSubtractionCounter)
                        
                        beatCardToBeHighlighted?.backgroundColor = .clear
                        
                    } else if self.divisor ==  4 {
                        let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterFadeClear - self.sixteenthNoteSubtractionCounter)
                        
                        beatCardToBeHighlighted?.backgroundColor = .clear
                        
                    }
                    
                    cardCounterFadeClear += 4
                    
                    if cardCounterFadeClear >= (self.beepCounter + 1)/self.divisor + 24{
                    cardCounterFadeClear = 1
                    }
                    
                }
                
                self.eighthNoteSubtractionCounter += 1
                if self.eighthNoteSubtractionCounter >= 4 {
                    self.eighthNoteSubtractionCounter = 0
                }
                
                self.sixteenthNoteSubtractionCounter += 3
                if self.sixteenthNoteSubtractionCounter >= 12 {
                    self.sixteenthNoteSubtractionCounter = 0
                }
                print("showHighlightBar executed")
            }
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
            
            sequencer.play()

       }
        
        
    }
        func stopMetronome() {
            print("metronomeToggleState inside if inside stopMetronome(): \(metronomeToggleState)")
            sequencer.stop()
            resetHighlightBar()
        }
        
        
    
    
    func changeSubdivision(subdivision: Int) {
//        self.subdivision = subdivision
//        sequencer.subdivision = subdivision
        
        divisor = subdivision/4
        
        if divisor == 1 {
            sequencer.tempo = Double(homeScreenViewController.currentBPM)
        } else if divisor == 2 {
            sequencer.tempo = Double(homeScreenViewController.currentBPM * 2)
        } else if divisor == 4 {
            sequencer.tempo = Double(homeScreenViewController.currentBPM * 4)
        }
    }
    
    func resetHighlightBar() {
        beepCounter = 0
        eighthNoteSubtractionCounter = 0
        sixteenthNoteSubtractionCounter = 0
    }
    
//    func resetMetronome() {
//        metronome.reset()
//        metronome.stop()
//        metronome.currentBeat = -1
//        beepCounter = 0
//        
//    }
    
    

    }


