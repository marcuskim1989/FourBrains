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
    var measureCounter = 1
    
    init(homeScreenViewController: HomeScreenViewController) {
        
        metronome = AKMetronome()
        self.homeScreenViewController = homeScreenViewController
        print("initial tempo: \(metronome.tempo)")
        metronome.callback = { // only called when showHighlightBar() is called
            var cardCounterWhiteOut = self.measureCounter
            var cardCounterFadeClear = self.measureCounter
            let deadlineTime = DispatchTime.now() + (60/self.metronome.tempo) / 10.0
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                for card in 0...3 {
                    let beatCardToBeHighlighted = homeScreenViewController.view.viewWithTag(cardCounterWhiteOut)
                
                    beatCardToBeHighlighted?.backgroundColor = .white
                
                    cardCounterWhiteOut += 4
                    if cardCounterWhiteOut >= self.measureCounter + 13{
                    cardCounterWhiteOut = 1
                    }
                }
                UIView.animate(withDuration: (60/self.metronome.tempo)){
                    for card in 0...3 {
                        let beatCardToBeHighlighted = self.homeScreenViewController.view.viewWithTag(cardCounterFadeClear)
                        
                        beatCardToBeHighlighted?.backgroundColor = .clear
                        
                        cardCounterFadeClear += 4
                        if cardCounterFadeClear >= self.measureCounter + 13{
                            cardCounterFadeClear = 1
                        }
                        
                    }
                    
                    print("showHighlightBar executed")
                }
                self.measureCounter += 1
                if self.measureCounter >= 5 {
                    self.measureCounter = 1
                }
            }
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
        }
        
        
    }
    
    func resetHighlightBar() {
        measureCounter = 1
    }
    
    func resetMetronome() {
        metronome.stop()
        metronome.reset()
    }
    
    }

