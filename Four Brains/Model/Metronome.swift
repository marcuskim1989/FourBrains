//
//  Metronome.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/6/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit

class Metronome {
    
    var metronome: AKMetronome!
    var homeScreenViewController: HomeScreenViewController!
    var metronomeToggleState = true
    var subdivision = 4
    var divisor = 1
    var beepCounter = 0
    var eighthNoteSubtractionCounter = 0
    var sixteenthNoteSubtractionCounter = 0
    
    init(homeScreenViewController: HomeScreenViewController) {
        
        
        
        metronome = AKMetronome()
        self.homeScreenViewController = homeScreenViewController
        print("initial tempo: \(metronome.tempo)")
        metronome.callback = {
            
            if self.beepCounter >= self.subdivision {
                self.beepCounter = 0
            }
            
            //when the divisor is 1, highlight bar will shine every 1 beat. when the divisor is 2, the highlight bar will shine every 2 beats. When the divisor is 4, the highlight bar will shine every 4 beats. maybe make a counter variable that calls the closure every multiple of the divisor. can I use the measure counter as the counter variable?
            var cardCounterWhiteOut = self.beepCounter + 1
            var cardCounterFadeClear = self.beepCounter + 1
            
            if self.beepCounter % self.divisor == 0 {
            
            let deadlineTime = DispatchTime.now() + (60/self.metronome.tempo) / 10.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                
                for _ in 0...3 {
                    if self.divisor == 1{
                        let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterWhiteOut)
                        beatCardToBeHighlighted?.backgroundColor = .white
                        print("beepCounter is \(self.beepCounter), cardCounterWhiteOut is \(cardCounterWhiteOut)")
                    }else if self.divisor == 2 {
                        let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterWhiteOut - self.eighthNoteSubtractionCounter)
                        
                        beatCardToBeHighlighted?.backgroundColor = .white
                        print("beepCounter is \(self.beepCounter), cardCounterWhiteOut is \(cardCounterWhiteOut), eightNoteSubtractionCounter is \(self.eighthNoteSubtractionCounter), cardCounterWhiteOut - eightNoteSubtractionCounter is \(cardCounterWhiteOut - self.eighthNoteSubtractionCounter)")
                    } else if self.divisor ==  4 {
                        let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterWhiteOut - self.sixteenthNoteSubtractionCounter)
                        
                        beatCardToBeHighlighted?.backgroundColor = .white
                        print("noteCounter is \(self.beepCounter), cardCounterWhiteOut is \(cardCounterWhiteOut), eightNoteSubtractionCounter is \(self.eighthNoteSubtractionCounter), cardCounterWhiteOut - eightNoteSubtractionCounter is \(cardCounterWhiteOut - self.eighthNoteSubtractionCounter)")
                    }
                    
                    
                    cardCounterWhiteOut += 4
                    
                    
                    if cardCounterWhiteOut >= (self.beepCounter + 1)/self.divisor + 24{
                    cardCounterWhiteOut = 1
                    }
                }
                
                UIView.animate(withDuration: (60/self.metronome.tempo)){
                    for _ in 0...3 {
                        if self.divisor == 1{
                            let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterFadeClear)
                            beatCardToBeHighlighted?.backgroundColor = .clear
                        }else if self.divisor == 2 {
                            let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterFadeClear - self.eighthNoteSubtractionCounter)
                            
                            beatCardToBeHighlighted?.backgroundColor = .clear
                            
                        } else if self.divisor ==  4 {
                            let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterFadeClear - self.sixteenthNoteSubtractionCounter)
                            
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
            self.beepCounter += 1
            
            print("call back executed")
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
            
            metronome.restart()

        } else {
            print("metronomeToggleState inside if inside playMetronome(): \(metronomeToggleState)")
            metronome.stop()
            metronome.reset()
            resetHighlightBar()
        }
        
        
    }
    
    func changeSubdivision(subdivision: Int) {
        self.subdivision = subdivision
        metronome.subdivision = subdivision
        
        divisor = subdivision/4
        
        if divisor == 1 {
            metronome.tempo = Double(homeScreenViewController.currentBPM)
        } else if divisor == 2 {
            metronome.tempo = Double(homeScreenViewController.currentBPM * 2)
        } else if divisor == 4 {
            metronome.tempo = Double(homeScreenViewController.currentBPM * 4)
        }
    }
    
    func resetHighlightBar() {
        beepCounter = 0
        eighthNoteSubtractionCounter = 0
        sixteenthNoteSubtractionCounter = 0
    }
    
    func resetMetronome() {
        metronome.stop()
        metronome.reset()
    }
    
    }

