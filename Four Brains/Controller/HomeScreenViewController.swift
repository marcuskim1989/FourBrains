//
//  ViewController.swift
//  Four Brains
//
//  Created by Marcus Kim on 1/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

/*
 This code currently needs to be refactored.
 
 TODO:
 1) make sure all attributes are only accessible by the class's methods. Aka, make attributes private where you can
 
 2) make sure methods don't cause a "chain reaction" caused by one method calling another method, which then calls another. Instead, create one method that calls the other methods from one code block
 
 3) use toggleables to change bool states. Currently, it is using if/else statements. toggleables would be perfect in Mute and PlayBackEngine
 
 */


import UIKit
import AudioKit
import HGCircularSlider
import McPicker

class HomeScreenViewController: UIViewController, BPMAdjustorDelegate {

    //MARK:- variables and outlets
    
    private var metronome: Metronome!
    private var playBackEngine: PlayBackEngine!
    private var drumSounds: DrumSounds!
    private var randomization: Randomization!
    private var beatCardInstances: K.BeatCardInstances!
    private var mute: Mute!
    private var snooze: Snooze!
    private var wholeBeat: WholeBeat!
    private var currentBPM: Int = 60
    private var subdivision: Int = 4
    private var mixer = Mixer()
    
    public static let engine = AudioEngine()
    
    //beat card image array holds beat card image literals
    let beatCardImageArray: [UIImage] = [#imageLiteral(resourceName: "0"), #imageLiteral(resourceName: "1A"), #imageLiteral(resourceName: "1B"), #imageLiteral(resourceName: "1C"), #imageLiteral(resourceName: "1D.png"), #imageLiteral(resourceName: "2A"), #imageLiteral(resourceName: "2B"), #imageLiteral(resourceName: "2C"), #imageLiteral(resourceName: "2D.png"), #imageLiteral(resourceName: "2E"), #imageLiteral(resourceName: "2F"), #imageLiteral(resourceName: "3A"), #imageLiteral(resourceName: "3B.png"), #imageLiteral(resourceName: "3C"), #imageLiteral(resourceName: "3D"), #imageLiteral(resourceName: "4")]
    
    //Ride cymbal beat card buttons. beat cards have tags 0 through 15 starting from the top left, moving across then down like a book
    
    @IBOutlet weak var ride0: UIButton!
    @IBOutlet weak var ride1: UIButton!
    @IBOutlet weak var ride2: UIButton!
    @IBOutlet weak var ride3: UIButton!
    
    
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
    private lazy var rideImageOutletArray = [ride0, ride1, ride2, ride3]
    private lazy var snareImageOutletArray = [snare0, snare1, snare2, snare3]
    private lazy var bassImageOutletArray = [bass0, bass1, bass2, bass3]
    private lazy var hiHatImageOutletArray = [hiHat0, hiHat1, hiHat2, hiHat3]
    
    //play panel outlets
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var metronomeOutlet: UIButton!
    @IBOutlet weak var bpmAdjustAccessButton: UIButton!
    @IBOutlet weak var subdivisionOutlet: UIButton!
    
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
    
    //MARK:- initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rideMuteOutlet.setTitle(K.MuteConstants.RIDE_MUTE_BUTTON, for: .normal)
        snareMuteOutlet.setTitle(K.MuteConstants.SNARE_MUTE_BUTTON, for: .normal)
        bassMuteOutlet.setTitle(K.MuteConstants.BASS_MUTE_BUTTON, for: .normal)
        hiHatMuteOutlet.setTitle(K.MuteConstants.HI_HAT_MUTE_BUTTON, for: .normal)
        
        rideSnoozeOutlet.setTitle(K.SnoozeConstants.RIDE_SNOOZE_BUTTON, for: .normal)
        snareSnoozeOutlet.setTitle(K.SnoozeConstants.SNARE_SNOOZE_BUTTON, for: .normal)
        bassSnoozeOutlet.setTitle(K.SnoozeConstants.BASS_SNOOZE_BUTTON, for: .normal)
        hiHatSnoozeOutlet.setTitle(K.SnoozeConstants.HI_HAT_SNOOZE_BUTTON, for: .normal)
        
        mute = Mute()
        drumSounds = DrumSounds(mute: self.mute, currentBPM: self.currentBPM)
        snooze = Snooze(mute: self.mute, drumSounds: self.drumSounds)
        metronome = Metronome(homeScreenViewController: self)
        playBackEngine = PlayBackEngine(metronome: self.metronome, drumSounds: self.drumSounds)
        randomization = Randomization()
        beatCardInstances = K.BeatCardInstances()
        
        mixer.addInput(drumSounds.getDrums())
        mixer.addInput(metronome.getFader())
        mixer.addInput(metronome.getCallbackInstrument())
        
        HomeScreenViewController.engine.output = mixer
        
        do {
            try HomeScreenViewController.engine.start()
        } catch {
            Log("AudioKit did not start! \(error)")
        }
        
        self.randomize()
        
    }
    
    public func getCurrentBPM() -> Int {
        return currentBPM
    }
    
    //MARK:- randomization
    
    @IBAction func randomizationButtonPressed(_ sender: Any) {
        self.randomize()
    }
    
    public func randomize() {
        wholeBeat = randomization.randomize(beatCardInstances: self.beatCardInstances, drumSounds: self.drumSounds)
        drumSounds.processDrumSounds(wholeBeat: wholeBeat)
        assignBeatCardImages(wholeBeat: wholeBeat)
        resetPlaySettings()
        resetMuteAndSnooze()
    }
    
    @IBAction func beatCardPressed(_ sender: UIButton) {
        let mcPicker = McPicker(data: K.BeatCardNoteStrings.BEAT_CARD_STRING_ARRAY)
        
        let customLabel = UILabel()
        customLabel.textAlignment = .center
        customLabel.textColor = .white
        customLabel.font = UIFont(name:"American Typewriter", size: 30)!
        mcPicker.label = customLabel
        
        let fixedSpace = McPickerBarButtonItem.fixedSpace(width: 20.0)
        let flexibleSpace = McPickerBarButtonItem.flexibleSpace()
        let fireButton = McPickerBarButtonItem.done(mcPicker: mcPicker, title: "Fire!!!") // Set custom Text
        let cancelButton = McPickerBarButtonItem.cancel(mcPicker: mcPicker, barButtonSystemItem: .cancel) // or system items
        mcPicker.setToolbarItems(items: [fixedSpace, cancelButton, flexibleSpace, fireButton, fixedSpace])

        mcPicker.toolbarItemsFont = UIFont(name:"American Typewriter", size: 17)!

        mcPicker.toolbarButtonsColor = .white
        mcPicker.toolbarBarTintColor = .darkGray
        mcPicker.pickerBackgroundColor = .gray
        mcPicker.backgroundColor = .gray
        mcPicker.backgroundColorAlpha = 0.50

        
        mcPicker.showAsPopover(fromViewController: self, sourceView: sender) { [weak self] (selections: [Int : String]) -> Void in
            if let beatCard = selections[0] {
                sender.setImage(#imageLiteral(resourceName: "2D"), for: .normal)
            }
        }
        
    }
    
              
    
    
    func assignBeatCardImages(wholeBeat: WholeBeat) {
        
        for rideBeatCard in Range(0...3) {
            print("Ride: \(wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()): \(wholeBeat.getRidePattern()[rideBeatCard].getBeatCardNoteSequence())")
            
            rideImageOutletArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for snareBeatCard in Range(0...3) {
            print("Snare: \(wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel()): \(wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardNoteSequence())")
            
            snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel())
        }
        
        for bassBeatCard in Range(0...3) {
            print("Bass: \(wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel()): \(wholeBeat.getBassPattern()[bassBeatCard].getBeatCardNoteSequence())")
            
            bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel())
        }
        
        for hiHatBeatCard in Range(0...3) {
            print("Hi-Hat: \(wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel()): \(wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardNoteSequence())")
            
            hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel())
        }
        
    }
    
    //MARK:- Calling play functionality
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        let playButtonShouldBe = playBackEngine.changeIsPlaying()
        if playButtonShouldBe {
             playButtonOutlet.setImage(#imageLiteral(resourceName: "Stop Button"), for: .normal)
        } else {
            playButtonOutlet.setImage(#imageLiteral(resourceName: "Play Button"), for: .normal)
            
        }
        print("playButtonShouldBe: \(playButtonShouldBe)")
        playBackEngine.play()
    }
    
    //MARK:- calling metronome functionality
    
    @IBAction func metronomeTogglePressed(_ sender: UIButton) {
        let metronomeButtonShouldBe = metronome.changeMetronomeToggleState()
        
        print("metronomeButtonShouldBe: \(metronomeButtonShouldBe)")
       if metronomeButtonShouldBe {
            metronomeOutlet.setImage(#imageLiteral(resourceName: "Metronome Button"), for: .normal)
       } else {
            metronomeOutlet.setImage(#imageLiteral(resourceName: "Metronome Off"), for: .normal)
        }
        
        resetPlaySettings()
        
    }
    
    //MARK:- Subdivisions
    
    @IBAction func subdivisionButtonPressed(_ sender: UIButton) {
        
        subdivision *= 2
        if subdivision > 16{
            subdivision = 4
        }
        
        if subdivision == 4 {
            subdivisionOutlet.setImage(#imageLiteral(resourceName: "4 Beeps Image"), for: .normal)
        } else if subdivision == 8 {
            subdivisionOutlet.setImage(#imageLiteral(resourceName: "8 Beeps Image.png"), for: .normal)
        } else {
            subdivisionOutlet.setImage(#imageLiteral(resourceName: "16 Beeps Image"), for: .normal)
        }
        
        metronome.setTempo(subdivision: self.subdivision, currentBPM: self.currentBPM)
        metronome.stopMetronome()
        resetPlaySettings()
        
    }
    
    // MARK:- bpmAdjustor
    
    @IBAction func bpmAdjustorAccessButtonPressed(_ sender: UIButton) {
    
        self.performSegue(withIdentifier: "presentBPMAdjustor", sender: self)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentBPMAdjustor" {
            let bpmAdjustorVC = segue.destination as! BPMAdjustorViewController
            bpmAdjustorVC.setDelegate(self)
            bpmAdjustorVC.setCurrentBPM(self.currentBPM)
        }
    }
    
    func updateBPM(BPM: Int) {
        self.currentBPM = BPM
        bpmAdjustAccessButton.setTitle(String(currentBPM), for: .normal)
        metronome.setTempo(subdivision: self.subdivision, currentBPM: self.currentBPM)
        drumSounds.setSequencerTempo(Double(BPM))
        resetPlaySettings()
        resetMuteAndSnooze()
    }
    
    
    
    //MARK:- mute buttons
    @IBAction func mutePressed(_ sender: UIButton) {
        let buttonShouldBe: Bool = true
        
        //print("Mute button sender: \(sender.currentTitle)")
        if sender.currentTitle != nil {
            mute.changeMuteState(instrument: sender.currentTitle!)
            drumSounds.assignDrumSounds()
            print(buttonShouldBe)
            switch sender.currentTitle{
                       
            case K.MuteConstants.RIDE_MUTE_BUTTON:
                if !mute.getRideMuteState() && snooze.getRideSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
                        for rideBeatCard in Range(0...3) {
                            rideImageOutletArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
                            
                        }
                        snooze.changeSnoozeState(instrument: K.SnoozeConstants.RIDE_SNOOZE_BUTTON)
                       
                        
                    } else if mute.getRideMuteState() && !snooze.getRideSnoozeState(){ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Mute"), for: .normal)
                    } else if !mute.getRideMuteState() && !snooze.getRideSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
                }
                
            case K.MuteConstants.SNARE_MUTE_BUTTON:
                    if !mute.getSnareMuteState() && snooze.getSnareSnoozeState(){ // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
                        for snareBeatCard in Range(0...3) {
                            snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel())
                            
                        }
                        snooze.changeSnoozeState(instrument: K.SnoozeConstants.SNARE_SNOOZE_BUTTON)
                       
                        
                    } else if mute.getSnareMuteState() && !snooze.getSnareSnoozeState(){ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Mute"), for: .normal)
                    } else if !mute.getSnareMuteState() && !snooze.getSnareSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                        snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
                }
                
            case K.MuteConstants.BASS_MUTE_BUTTON:
                if !mute.getBassMuteState() && snooze.getBassSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
                        for bassBeatCard in Range(0...3) {
                            bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel())
                            
                        }
                        snooze.changeSnoozeState(instrument: K.SnoozeConstants.BASS_SNOOZE_BUTTON)
                       
                        
                    } else if mute.getBassMuteState() && !snooze.getBassSnoozeState(){ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Mute"), for: .normal)
                    } else if !mute.getBassMuteState() && !snooze.getBassSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                        bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
                }
                
            case K.MuteConstants.HI_HAT_MUTE_BUTTON:
                    if !mute.getHiHatMuteState() && snooze.getHiHatSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                        hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat "), for: .normal)
                        for hiHatBeatCard in Range(0...3) {
                            hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel())
                            
                        }
                        snooze.changeSnoozeState(instrument: K.SnoozeConstants.HI_HAT_SNOOZE_BUTTON)
                       
                        
                    } else if mute.getHiHatMuteState() && !snooze.getHiHatSnoozeState(){ // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat Mute"), for: .normal)
                    } else if !mute.getHiHatMuteState() && !snooze.getHiHatSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
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
        
        print("unmuteUI() called")
    }
    
    // MARK:- snoozing
    
    @IBAction func snoozeButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle != nil {
            snooze.changeSnoozeState(instrument: sender.currentTitle!)
            print("Snooze Button Sender: \(sender.currentTitle!)")
            
            switch sender.currentTitle {
            case K.SnoozeConstants.RIDE_SNOOZE_BUTTON:
                    if mute.getRideMuteState() && snooze.getRideSnoozeState() {// if it is already muted, and you want to snooze, simply snooze.
                        
                        ride0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        ride1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        ride2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        ride3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        
                    } else if !mute.getRideMuteState() && snooze.getRideSnoozeState(){ // if it is not muted, and you want to snooze, mute and snooze. //change persist variable to false
                        mute.changeMuteState(instrument: K.MuteConstants.RIDE_MUTE_BUTTON)
                        drumSounds.assignDrumSounds()
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Mute"), for: .normal)
                        ride0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        ride1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        ride2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        ride3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    
                    } else if mute.getRideMuteState() && !snooze.getRideSnoozeState(){ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                        
                        for rideBeatCard in Range(0...3) {
                            rideImageOutletArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
                        }
                        
                        mute.changeMuteState(instrument: K.MuteConstants.RIDE_MUTE_BUTTON)
                        drumSounds.assignDrumSounds()
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: "Ride Cymbal.png"), for: .normal)
    
                }
                
            case K.SnoozeConstants.SNARE_SNOOZE_BUTTON:
                                if mute.getSnareMuteState() && snooze.getSnareSnoozeState() {// if it is already muted, and you want to snooze, simply snooze.
                                    
                                    snare0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    
                                } else if !mute.getSnareMuteState() && snooze.getSnareSnoozeState(){ // if it is not muted, and you want to snooze, mute and snooze.
                                    mute.changeMuteState(instrument: K.MuteConstants.SNARE_MUTE_BUTTON)
                                    drumSounds.assignDrumSounds()
                                    snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Mute"), for: .normal)
                                    snare0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    snare3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                
                                } else if mute.getSnareMuteState() && !snooze.getSnareSnoozeState(){ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                                    for snareBeatCard in Range(0...3) {
                                    snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel())
                                    }
                                    
                                    mute.changeMuteState(instrument: K.MuteConstants.SNARE_MUTE_BUTTON)
                                    drumSounds.assignDrumSounds()
                                    snareMuteOutlet.setImage(#imageLiteral(resourceName: "Snare Drum Clear"), for: .normal)
                
                            }
                
            case K.SnoozeConstants.BASS_SNOOZE_BUTTON:
                                if mute.getBassMuteState() && snooze.getBassSnoozeState() {// if it is already muted, and you want to snooze, simply snooze.
                                    
                                    bass0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    
                                } else if !mute.getBassMuteState() && snooze.getBassSnoozeState(){ // if it is not muted, and you want to snooze, mute and snooze.
                                    mute.changeMuteState(instrument: K.MuteConstants.BASS_MUTE_BUTTON)
                                    drumSounds.assignDrumSounds()
                                    bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Mute"), for: .normal)
                                    bass0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    bass3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                
                                } else if mute.getBassMuteState() && !snooze.getBassSnoozeState(){ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                                    for bassBeatCard in Range(0...3) {
                                    bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel())
                                    }
                                    
                                    mute.changeMuteState(instrument: K.MuteConstants.BASS_MUTE_BUTTON)
                                    drumSounds.assignDrumSounds()
                                    bassMuteOutlet.setImage(#imageLiteral(resourceName: "Bass Drum"), for: .normal)
                
                            }
                
            case K.SnoozeConstants.HI_HAT_SNOOZE_BUTTON:
                                if mute.getHiHatMuteState() && snooze.getHiHatSnoozeState() {// if it is already muted, and you want to snooze, simply snooze.
                                    
                                    hiHat0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    
                                } else if !mute.getHiHatMuteState() && snooze.getHiHatSnoozeState() { // if it is not muted, and you want to snooze, mute and snooze. \
                                    mute.changeMuteState(instrument: K.MuteConstants.HI_HAT_MUTE_BUTTON)
                                    drumSounds.assignDrumSounds()
                                    hiHatMuteOutlet.setImage(#imageLiteral(resourceName: "Hi Hat Mute"), for: .normal)
                                    hiHat0.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat1.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat2.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                    hiHat3.image = #imageLiteral(resourceName: "Snoozed Beat Card")
                                
                                } else if mute.getHiHatMuteState() && !snooze.getHiHatSnoozeState(){ // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                                    for hiHatBeatCard in Range(0...3) {
                                    hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel())
                                    }
                                    
                                    mute.changeMuteState(instrument: K.MuteConstants.HI_HAT_MUTE_BUTTON)
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
            rideImageOutletArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for snareBeatCard in Range(0...3) {
        snareImageOutletArray[snareBeatCard]?.image = UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel())
        }
        
        for bassBeatCard in Range(0...3) {
        bassImageOutletArray[bassBeatCard]?.image = UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel())
        }
        
        for hiHatBeatCard in Range(0...3) {
        hiHatImageOutletArray[hiHatBeatCard]?.image = UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel())
        }
    }
    
    //MARK:- reset
    func resetPlaySettings() {
        if playBackEngine.getIsPlaying(){
            metronome.stopMetronome()
            drumSounds.stopDrumsSounds()
            _ = playBackEngine.changeIsPlaying()
            playButtonOutlet.setImage(#imageLiteral(resourceName: "Play Button"), for: .normal)
        }
    }
    
    func resetMuteAndSnooze() {
        mute.unmuteAllStates()
        unmuteUI()
        snooze.unsnoozeAllStates()
        unsnoozeUI()
        drumSounds.assignDrumSounds()
    }
 
}

