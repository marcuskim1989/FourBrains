//
//  ViewController.swift
//  Four Brains
//
//  Created by Marcus Kim on 1/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import UIKit
import AudioKit
import HGCircularSlider

class HomeScreenViewController: UIViewController, BPMAdjustorDelegate {

    //MARK: variables and outlets
    
    var metronome: Metronome!
    var playBackEngine: PlayBackEngine!
    var drumSounds: DrumSounds!
    var randomization: Randomization!
    var beatCardInstances: BeatCardInstances!
    var mute: Mute!
    var snooze: Snooze!
    var wholeBeat: WholeBeat!
    var currentBPM: Int = 60
    
    
    //beat card image array holds beat card image literals
    let beatCardImageArray: [UIImage] = [#imageLiteral(resourceName: "0"), #imageLiteral(resourceName: "1A"), #imageLiteral(resourceName: "1B"), #imageLiteral(resourceName: "1C"), #imageLiteral(resourceName: "1D.png"), #imageLiteral(resourceName: "2A"), #imageLiteral(resourceName: "2B"), #imageLiteral(resourceName: "2C"), #imageLiteral(resourceName: "2D.png"), #imageLiteral(resourceName: "2E"), #imageLiteral(resourceName: "2F"), #imageLiteral(resourceName: "3A"), #imageLiteral(resourceName: "3B.png"), #imageLiteral(resourceName: "3C"), #imageLiteral(resourceName: "3D"), #imageLiteral(resourceName: "4")]
    
    //Ride cymbal beat card image views. beat cards have tags 0 through 15 starting from the top left, moving across then down like a book
    @IBOutlet weak var ride0: UIImageView!
    @IBOutlet weak var ride1: UIImageView!
    @IBOutlet weak var ride2: UIImageView!
    @IBOutlet weak var ride3: UIImageView!
    
    //snare beat card image views
    @IBOutlet weak var snare0: UIImageView!
    @IBOutlet weak var snare1: UIImageView!
    @IBOutlet weak var snare2: UIImageView!
    @IBOutlet weak var snare3: UIImageView!
    
    // bass drum beat card image view
    @IBOutlet weak var bass0: UIImageView!
    @IBOutlet weak var bass1: UIImageView!
    @IBOutlet weak var bass2: UIImageView!
    @IBOutlet weak var bass3: UIImageView!
    
    // hi hat beat card image views
    @IBOutlet weak var hiHat0: UIImageView!
    @IBOutlet weak var hiHat1: UIImageView!
    @IBOutlet weak var hiHat2: UIImageView!
    @IBOutlet weak var hiHat3: UIImageView!
    
    //Beat Card Image Outlet Array
    lazy var rideImageOutletArray = [ride0, ride1, ride2, ride3]
    lazy var snareImageOutletArray = [snare0, snare1, snare2, snare3]
    lazy var bassImageOutletArray = [bass0, bass1, bass2, bass3]
    lazy var hiHatImageOutletArray = [hiHat0, hiHat1, hiHat2, hiHat3]
    
    //play panel outlets
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var metronomeOutlet: UIButton!
    @IBOutlet weak var bpmAdjustAccessButton: UIButton!
    
    //mute button outlets
    @IBOutlet weak var rideMuteOutlet: UIButton!
    @IBOutlet weak var snareMuteOutlet: UIButton!
    @IBOutlet weak var bassMuteOutlet: UIButton!
    @IBOutlet weak var hiHatMuteOutlet: UIButton!
    
    //snooze button outlets
    @IBOutlet weak var rideSnoozeOutlet: UIButton!
    @IBOutlet weak var snareSnoozeOutlet: UIButton!
    @IBOutlet weak var bassSnoozeOutlet: UIButton!
    @IBOutlet weak var hiHatSnoozeOutlet: UIButton!
    
    
    //MARK: initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mute = Mute()
        drumSounds = DrumSounds(mute: self.mute)
        snooze = Snooze(mute: self.mute, drumSounds: self.drumSounds)
        metronome = Metronome(homeScreenViewController: self)
        playBackEngine = PlayBackEngine(metronome: self.metronome, drumSounds: self.drumSounds)
        randomization = Randomization()
        beatCardInstances = BeatCardInstances()
        
        do {
            try AudioKit.start()
        } catch {
            print("AudioKit did not start.")
        }
        startRandomization()
    }
    
    //MARK: Calling play functionality
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        let playButtonShouldBe = playBackEngine.changeIsPlaying()
        if playButtonShouldBe {
             playButtonOutlet.setImage(#imageLiteral(resourceName: "Stop Button"), for: .normal)
        } else {
            playButtonOutlet.setImage(#imageLiteral(resourceName: "Play Button"), for: .normal)
            
        }
        print("playButtonShouldBe: \(playButtonShouldBe)")
        playBackEngine.play()
        showHighlightBar()
    }
    
    //MARK: calling metronome functionality
    
    @IBAction func metronomeTogglePressed(_ sender: UIButton) {
        let metronomeButtonShouldBe = metronome.changeMetronomeToggleState()
        
        print("metronomeButtonShouldBe: \(metronomeButtonShouldBe)")
       if metronomeButtonShouldBe {
            metronomeOutlet.setImage(#imageLiteral(resourceName: "Metronome Button"), for: .normal)
       } else {
            metronomeOutlet.setImage(#imageLiteral(resourceName: "Metronome Off"), for: .normal)
        }
       
        reset()
    }
    
    // MARK: highlight bar
    
    func showHighlightBar() {
        
        
        
    }
    
    // MARK: bpmAdjustor
    
    @IBAction func bpmAdjustorAccessButtonPressed(_ sender: UIButton) {
    
        self.performSegue(withIdentifier: "presentBPMAdjustor", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentBPMAdjustor" {
            let bpmAdjustorVC = segue.destination as! BPMAdjustorViewController
            bpmAdjustorVC.delegate = self
            bpmAdjustorVC.currentBPM = self.currentBPM
        }
    }
    
    func updateBPM(BPM: Int) {
        self.currentBPM = BPM
        bpmAdjustAccessButton.setTitle(String(currentBPM), for: .normal)
        metronome.metronome.tempo = Double(BPM)
        drumSounds.sequencer.setTempo(Double(BPM))
        reset()
    }
    
    //MARK: randomize beat card images
    
    @IBAction func randomizationButtonPressed(_ sender: Any) {
        
        startRandomization()
        
        drumSounds.assignDrumSounds()
        
    }
    
    func startRandomization() {
        wholeBeat = randomization.randomize(beatCardInstances: self.beatCardInstances, drumSounds: self.drumSounds)
        
        for rideBeatCard in Range(0...3) {
            print("Ride: \(wholeBeat.ridePattern[rideBeatCard].beatCardLabel): \(wholeBeat.ridePattern[rideBeatCard].beatCardNoteSequence)")
            
            rideImageOutletArray[rideBeatCard]?.image = UIImage(named: wholeBeat.ridePattern[rideBeatCard].beatCardLabel)
        }
        
        for snareBeatCard in Range(0...3) {
            print("Snare: \(wholeBeat.snarePattern[snareBeatCard].beatCardLabel): \(wholeBeat.snarePattern[snareBeatCard].beatCardNoteSequence)")
            
            snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.snarePattern[snareBeatCard].beatCardLabel)
        }
        
        for bassBeatCard in Range(0...3) {
            print("Bass: \(wholeBeat.bassPattern[bassBeatCard].beatCardLabel): \(wholeBeat.bassPattern[bassBeatCard].beatCardNoteSequence)")
            
            bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.bassPattern[bassBeatCard].beatCardLabel)
        }
        
        for hiHatBeatCard in Range(0...3) {
            print("Hi-Hat: \(wholeBeat.hiHatPattern[hiHatBeatCard].beatCardLabel): \(wholeBeat.hiHatPattern[hiHatBeatCard].beatCardNoteSequence)")
            
            hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.hiHatPattern[hiHatBeatCard].beatCardLabel)
        }
        
        
        reset()
        
    }
    
    //MARK: mute buttons
    @IBAction func mutePressed(_ sender: UIButton) {
        var buttonShouldBe: Bool = true
        
        print("Mute button sender: \(sender.currentTitle)")
        if sender.currentTitle != nil {
            !mute.changeMuteState(instrument: sender.currentTitle!)
            drumSounds.assignDrumSounds()
            print(buttonShouldBe)
            switch sender.currentTitle{
                       
                case "rideMuteButton":
                    if !mute.rideMuteState && snooze.rideSnoozeState { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
                        for rideBeatCard in Range(0...3) {
                            rideImageOutletArray[rideBeatCard]?.image = UIImage(named: wholeBeat.ridePattern[rideBeatCard].beatCardLabel)
                            
                        }
                        snooze.changeSnoozeState(instrument: "rideSnooze")
                       
                        
                    } else if mute.rideMuteState && !snooze.rideSnoozeState{ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Mute"), for: .normal)
                    } else if !mute.rideMuteState && !snooze.rideSnoozeState { // if it is not snoozed, and you want to unmute, simply unmute.
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
                }
                
                case "snareMuteButton":
                    if !mute.snareMuteState && snooze.snareSnoozeState { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
                        for snareBeatCard in Range(0...3) {
                            snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.snarePattern[snareBeatCard].beatCardLabel)
                            
                        }
                        snooze.changeSnoozeState(instrument: "snareSnooze")
                       
                        
                    } else if mute.snareMuteState && !snooze.snareSnoozeState{ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Mute"), for: .normal)
                    } else if !mute.snareMuteState && !snooze.snareSnoozeState { // if it is not snoozed, and you want to unmute, simply unmute.
                        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
                }
                
                case "bassMuteButton":
                    if !mute.bassMuteState && snooze.bassSnoozeState { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
                        for bassBeatCard in Range(0...3) {
                            bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.bassPattern[bassBeatCard].beatCardLabel)
                            
                        }
                        snooze.changeSnoozeState(instrument: "bassSnooze")
                       
                        
                    } else if mute.bassMuteState && !snooze.bassSnoozeState{ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Mute"), for: .normal)
                    } else if !mute.bassMuteState && !snooze.bassSnoozeState { // if it is not snoozed, and you want to unmute, simply unmute.
                        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
                }
                
                case "hiHatMuteButton":
                    if !mute.hiHatMuteState && snooze.hiHatSnoozeState { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat "), for: .normal)
                        for hiHatBeatCard in Range(0...3) {
                            hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.hiHatPattern[hiHatBeatCard].beatCardLabel)
                            
                        }
                        snooze.changeSnoozeState(instrument: "hiHatSnooze")
                       
                        
                    } else if mute.hiHatMuteState && !snooze.hiHatSnoozeState{ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat Mute"), for: .normal)
                    } else if !mute.hiHatMuteState && !snooze.hiHatSnoozeState { // if it is not snoozed, and you want to unmute, simply unmute.
                        hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat "), for: .normal)
                }
                
                default:
                    print("error, sender.currentTitle case not found")
            }
        } else {
            print("Error: no sender title exists")
        }
        
    
           
        
    }
    
    //unmute UI
    func unmuteUI() {
        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
        hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat "), for: .normal)
    }
    
    // MARK: snoozing
    
    @IBAction func snoozeButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle != nil {
            snooze.changeSnoozeState(instrument: sender.currentTitle!)
            print("Snooze Button Sender: \(sender.currentTitle!)")
            
            switch sender.currentTitle {
                case "rideSnooze":
                    if mute.rideMuteState && snooze.rideSnoozeState {// if it is already muted, and you want to snooze, simply snooze.
                        
                        ride0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        ride1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        ride2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        ride3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        
                    } else if !mute.rideMuteState && snooze.rideSnoozeState{ // if it is not muted, and you want to snooze, mute and snooze. //change persist variable to false
                        mute.changeMuteState(instrument: "rideMuteButton")
                        drumSounds.assignDrumSounds()
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Mute"), for: .normal)
                        ride0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        ride1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        ride2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                        ride3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                    
                    } else if mute.rideMuteState && !snooze.rideSnoozeState{ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                        
                        for rideBeatCard in Range(0...3) {
                        rideImageOutletArray[rideBeatCard]?.image = UIImage(named: wholeBeat.ridePattern[rideBeatCard].beatCardLabel)
                        }
                        
                        mute.changeMuteState(instrument: "rideMuteButton")
                        drumSounds.assignDrumSounds()
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
    
                }
                
                case "snareSnooze":
                                if mute.snareMuteState && snooze.snareSnoozeState {// if it is already muted, and you want to snooze, simply snooze.
                                    
                                    snare0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    
                                } else if !mute.snareMuteState && snooze.snareSnoozeState{ // if it is not muted, and you want to snooze, mute and snooze.
                                    mute.changeMuteState(instrument: "snareMuteButton")
                                    drumSounds.assignDrumSounds()
                                    snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Mute"), for: .normal)
                                    snare0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                
                                } else if mute.snareMuteState && !snooze.snareSnoozeState{ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                                    for snareBeatCard in Range(0...3) {
                                    snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.snarePattern[snareBeatCard].beatCardLabel)
                                    }
                                    
                                    mute.changeMuteState(instrument: "snareMuteButton")
                                    drumSounds.assignDrumSounds()
                                    snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
                
                            }
                
                case "bassSnooze":
                                if mute.bassMuteState && snooze.bassSnoozeState {// if it is already muted, and you want to snooze, simply snooze.
                                    
                                    bass0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    
                                } else if !mute.bassMuteState && snooze.bassSnoozeState{ // if it is not muted, and you want to snooze, mute and snooze.
                                    mute.changeMuteState(instrument: "bassMuteButton")
                                    drumSounds.assignDrumSounds()
                                    bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Mute"), for: .normal)
                                    bass0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                
                                } else if mute.bassMuteState && !snooze.bassSnoozeState{ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                                    for bassBeatCard in Range(0...3) {
                                    bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.bassPattern[bassBeatCard].beatCardLabel)
                                    }
                                    
                                    mute.changeMuteState(instrument: "bassMuteButton")
                                    drumSounds.assignDrumSounds()
                                    bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
                
                            }
                
                case "hiHatSnooze":
                                if mute.hiHatMuteState && snooze.hiHatSnoozeState {// if it is already muted, and you want to snooze, simply snooze.
                                    
                                    hiHat0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    
                                } else if !mute.hiHatMuteState && snooze.hiHatSnoozeState{ // if it is not muted, and you want to snooze, mute and snooze. \
                                    mute.changeMuteState(instrument: "hiHatMuteButton")
                                    drumSounds.assignDrumSounds()
                                    hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat Mute"), for: .normal)
                                    hiHat0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                
                                } else if mute.hiHatMuteState && !snooze.hiHatSnoozeState{ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                                    for hiHatBeatCard in Range(0...3) {
                                    hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.hiHatPattern[hiHatBeatCard].beatCardLabel)
                                    }
                                    
                                    mute.changeMuteState(instrument: "hiHatMuteButton")
                                    drumSounds.assignDrumSounds()
                                    hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat "), for: .normal)
                
                            }
                
                default:
                    print("Error: snooze button title not matched")
            }
        
        } else {
            print("Snooze: sender.currentTitle is nil")
        }
        
    }
    func unsnoozeUI () {
        
        for rideBeatCard in Range(0...3) {
        rideImageOutletArray[rideBeatCard]?.image = UIImage(named: wholeBeat.ridePattern[rideBeatCard].beatCardLabel)
        }
        
        for snareBeatCard in Range(0...3) {
        snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.snarePattern[snareBeatCard].beatCardLabel)
        }
        
        for bassBeatCard in Range(0...3) {
        bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.bassPattern[bassBeatCard].beatCardLabel)
        }
        
        for hiHatBeatCard in Range(0...3) {
        hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.hiHatPattern[hiHatBeatCard].beatCardLabel)
        }
    }
    
    //MARK: reset UI
    func reset() {
        if playBackEngine.isPlaying == true {
            metronome.metronome.stop()
            metronome.metronome.reset()
            drumSounds.sequencer.stop()
            drumSounds.sequencer.rewind()
            playBackEngine.changeIsPlaying()
            playButtonOutlet.setImage(#imageLiteral(resourceName: "Play Button"), for: .normal)
            mute.unmuteAllStates()
            unmuteUI()
            snooze.unsnoozeAllStates()
            unsnoozeUI()
            metronome.resetHighlightBar()
        }
    }
 
}

