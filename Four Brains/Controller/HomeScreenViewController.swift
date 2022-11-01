//
//  ViewController.swift
//  Four Brains
//
//  Created by Marcus Kim on 1/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

/*
    This code currently needs to be refactored.
    TODO: -
    1) make sure all attributes are only accessible by the class's methods. Aka, make attributes private where you can
    2) make sure methods don't cause a "chain reaction" caused by one method calling another method, which then calls another. Instead, create one method that calls the other methods from one code block
 
    3) use toggleables to change bool states. Currently, it is using if/else statements. toggleables would be perfect in Mute and PlayBackEngine
 
*/


import UIKit
import AudioKit
import McPicker

extension UIView {
   func makeVertical() {
        transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
   }
}

class HomeScreenViewController: UIViewController {

    // MARK: - Member variables
    
    private var metronome: Metronome!
    internal var playBackEngine: PlayBackEngine!
    internal var drumSounds: DrumSounds!
    private var randomization: Randomization!
    private var beatCardInstances: K.BeatCardInstances!
    private var mute: Mute!
    private var snooze: Snooze!
    internal var wholeBeat: WholeBeat!
    private var currentBPM: Int = 60
    private var subdivision: Int = 4
    private var mixer: Mixer = Mixer()
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        true
    }
    
    public func getBeatCardInstances() -> K.BeatCardInstances {
        return beatCardInstances
    }
    
    public func getWholeBeat() -> WholeBeat {
        return wholeBeat
    }
    
    public static let engine: AudioEngine = AudioEngine()
    
    // beat card image array holds beat card image literals
    let beatCardImageArray: [UIImage] = [#imageLiteral(resourceName: "0"), #imageLiteral(resourceName: "1A"), #imageLiteral(resourceName: "1B"), #imageLiteral(resourceName: "1C"), #imageLiteral(resourceName: "1D.png"), #imageLiteral(resourceName: "2A"), #imageLiteral(resourceName: "2B"), #imageLiteral(resourceName: "2C"), #imageLiteral(resourceName: "2D.png"), #imageLiteral(resourceName: "2E"), #imageLiteral(resourceName: "2F"), #imageLiteral(resourceName: "3A"), #imageLiteral(resourceName: "3B.png"), #imageLiteral(resourceName: "3C"), #imageLiteral(resourceName: "3D"), #imageLiteral(resourceName: "4")]
    
    
    // MARK: - Outlets and buttons
    // Ride cymbal beat card buttons. beat cards have tags 1 through 16 starting from the top left, moving across then down like a book
    
    @IBOutlet weak var ride0: UIButton!
    @IBOutlet weak var ride1: UIButton!
    @IBOutlet weak var ride2: UIButton!
    @IBOutlet weak var ride3: UIButton!
    
    // snare beat card image views
    @IBOutlet weak var snare0: UIButton!
    @IBOutlet weak var snare1: UIButton!
    @IBOutlet weak var snare2: UIButton!
    @IBOutlet weak var snare3: UIButton!
    
    // bass drum beat card image view
    @IBOutlet weak var kick0: UIButton!
    @IBOutlet weak var kick1: UIButton!
    @IBOutlet weak var kick2: UIButton!
    @IBOutlet weak var kick3: UIButton!
    
    // hi hat beat card image views
    @IBOutlet weak var hat0: UIButton!
    @IBOutlet weak var hat1: UIButton!
    @IBOutlet weak var hat2: UIButton!
    @IBOutlet weak var hat3: UIButton!
    
    // Beat Card Button Array
    private lazy var rideBeatCardButtonArray: [UIButton?] = [ride0, ride1, ride2, ride3]
    private lazy var snareBeatCardButtonArray: [UIButton?] = [snare0, snare1, snare2, snare3]
    private lazy var kickBeatCardButtonArray: [UIButton?] = [kick0, kick1, kick2, kick3]
    private lazy var hatBeatCardButtonArray: [UIButton?] = [hat0, hat1, hat2, hat3]
    
    // play panel outlets
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var metronomeOutlet: UIButton!
    @IBOutlet weak var subdivisionOutlet: UIButton!
    @IBOutlet weak var bpmPresenterOutlet: UIButton!
    @IBOutlet weak var bpmSliderOutlet: TransparentThumbSlider!
    
    
    // mute button outlets
    @IBOutlet weak var rideMuteOutlet: UIButton!
    @IBOutlet weak var snareMuteOutlet: UIButton!
    @IBOutlet weak var kickMuteOutlet: UIButton!
    @IBOutlet weak var hatMuteOutlet: UIButton!
    
    // snooze button outlets
    @IBOutlet weak var rideSnoozeOutlet: UIButton!
    @IBOutlet weak var snareSnoozeOutlet: UIButton!
    @IBOutlet weak var kickSnoozeOutlet: UIButton!
    @IBOutlet weak var hatSnoozeOutlet: UIButton!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rideMuteOutlet.setTitle(K.MuteConstants.MuteButtonNames.RIDE_MUTE_BUTTON, for: .normal)
        snareMuteOutlet.setTitle(K.MuteConstants.MuteButtonNames.SNARE_MUTE_BUTTON, for: .normal)
        kickMuteOutlet.setTitle(K.MuteConstants.MuteButtonNames.KICK_MUTE_BUTTON, for: .normal)
        hatMuteOutlet.setTitle(K.MuteConstants.MuteButtonNames.HAT_MUTE_BUTTON, for: .normal)
        
        rideSnoozeOutlet.setTitle(K.SnoozeConstants.RIDE_SNOOZE_BUTTON, for: .normal)
        snareSnoozeOutlet.setTitle(K.SnoozeConstants.SNARE_SNOOZE_BUTTON, for: .normal)
        kickSnoozeOutlet.setTitle(K.SnoozeConstants.BASS_SNOOZE_BUTTON, for: .normal)
        hatSnoozeOutlet.setTitle(K.SnoozeConstants.HI_HAT_SNOOZE_BUTTON, for: .normal)
        
        bpmSliderOutlet.makeVertical()
        bpmSliderOutlet.semanticContentAttribute = .forceRightToLeft
        bpmSliderOutlet.isHidden = true
        bpmSliderOutlet.configure()
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
    
    // MARK: - Randomization
    
    @IBAction func randomizationButtonPressed(_ sender: Any) {
        self.randomize()
    }
    
    public func randomize() {
        // wholeBeat is set to the returned wholeBeat from the randomization class, which is an object that has 4 members, each of which are an array of 4 beat card objects
        wholeBeat = randomization.randomize(beatCardInstances: self.beatCardInstances, drumSounds: self.drumSounds)
        
        //
        drumSounds.processDrumSounds(wholeBeat: wholeBeat)
        assignBeatCardImages(wholeBeat: wholeBeat)
        resetPlaySettings()
        resetMuteAndSnooze()
    }
    
    // MARK: - Pick Beat Cards
    
    @IBAction func beatCardPressed(_ sender: UIButton) {
        self.selectBeatCards(sender: sender)
    }
    
    // MARK: - Assign Beat Card images
    
    
    func assignBeatCardImages(wholeBeat: WholeBeat) {
        
        // loop through beat card button array. At each index, set the image for that beat card according to the label variable in each beat card object. Each label has a corresponding image
        for rideBeatCard in Range(0...3) {
            print("Ride: \(wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()): \(wholeBeat.getRidePattern()[rideBeatCard].getBeatCardNoteSequence())")
            
            rideBeatCardButtonArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for snareBeatCard in Range(0...3) {
            print("Snare: \(wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel()): \(wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardNoteSequence())")
            
            snareBeatCardButtonArray[snareBeatCard]?.setImage(UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for bassBeatCard in Range(0...3) {
            print("Bass: \(wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel()): \(wholeBeat.getBassPattern()[bassBeatCard].getBeatCardNoteSequence())")
            
            kickBeatCardButtonArray[bassBeatCard]?.setImage(UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for hiHatBeatCard in Range(0...3) {
            print("Hi-Hat: \(wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel()): \(wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardNoteSequence())")
            
            hatBeatCardButtonArray[hiHatBeatCard]?.setImage(UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel()), for: .normal)
        }
        
    }
    
    // MARK: - Playing beat
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        
        let playButtonShouldBe: Bool = playBackEngine.changeIsPlaying()
        if playButtonShouldBe {
            playButtonOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.STOP), for: .normal)
        } else {
            playButtonOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.PLAY), for: .normal)
            
        }
        print("playButtonShouldBe: \(playButtonShouldBe)")
        playBackEngine.play()
    }
    
    // MARK: - Metronome button pressed
    
    @IBAction func metronomeTogglePressed(_ sender: UIButton) {
        let metronomeButtonShouldBe: Bool = metronome.changeMetronomeToggleState()
        
        print("metronomeButtonShouldBe: \(metronomeButtonShouldBe)")
        if metronomeButtonShouldBe {
            metronomeOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.METRONOME_ACTIVE), for: .normal)
        } else {
            metronomeOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.METRONOME_MUTED), for: .normal)
        }
        
        resetPlaySettings()
        
    }
    
    // MARK: - Subdivision button pressed
    
    @IBAction func subdivisionButtonPressed(_ sender: UIButton) {
        
        subdivision *= 2
        if subdivision > 16 {
            subdivision = 4
        }
        
        if subdivision == 4 {
            subdivisionOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.SUBDIVISION_4TH), for: .normal)
        } else if subdivision == 8 {
            subdivisionOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.SUBDIVISION_8TH), for: .normal)
        } else {
            subdivisionOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.SUBDIVISION_16TH), for: .normal)
        }
        
        metronome.setTempo(subdivision: self.subdivision, currentBPM: self.currentBPM)
        metronome.stopMetronome()
        resetPlaySettings()
        
    }
    
    // MARK: - BPM
    
//    @IBAction func bpmPresenterPressed(_ sender: UIButton) {
//
//        bpmSliderOutlet.isHidden = false
//
//    }
    
    @IBAction func bpmSlid(_ sender: TransparentThumbSlider) {
        bpmPresenterOutlet.setTitle(String(Int(sender.value)), for: .normal)
        
    }
    

    @IBAction func bpmPresenterPressed(_ sender: UIButton) {
        
        bpmSliderOutlet.isHidden = false
        
    }
    
    @IBAction func bpmRelease(_ sender: TransparentThumbSlider) {
        
        bpmSliderOutlet.isHidden = true
        
        currentBPM = Int(sender.value)
        
        updateBPM(BPM: currentBPM)
        
    }
    
    func updateBPM(BPM: Int) {
        self.currentBPM = BPM
        metronome.setTempo(subdivision: self.subdivision, currentBPM: self.currentBPM)
        drumSounds.setSequencerTempo(Double(BPM))
        resetPlaySettings()
        resetMuteAndSnooze()
    }
    
    // MARK: - Mute buttons
    @IBAction func mutePressed(_ sender: UIButton) {
        let buttonShouldBe: Bool = true
        
        // print("Mute button sender: \(sender.currentTitle)")
        if sender.currentTitle != nil {
            mute.changeMuteState(instrument: sender.currentTitle!)
            drumSounds.assignDrumSounds()
            print(buttonShouldBe)
            switch sender.currentTitle {
                       
            case K.MuteConstants.MuteButtonNames.RIDE_MUTE_BUTTON:
                if !mute.getRideMuteState() && snooze.getRideSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                    rideMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.RIDE_IMAGE_ACTIVE), for: .normal)
                        for rideBeatCard in Range(0...3) {
                            rideBeatCardButtonArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
                            
                        }
                        snooze.changeSnoozeState(instrument: K.SnoozeConstants.RIDE_SNOOZE_BUTTON)
                       
                        
                    } else if mute.getRideMuteState() && !snooze.getRideSnoozeState() { // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.RIDE_IMAGE_MUTED), for: .normal)
                    } else if !mute.getRideMuteState() && !snooze.getRideSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                        rideMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.RIDE_IMAGE_ACTIVE), for: .normal)
                }
                
            case K.MuteConstants.MuteButtonNames.SNARE_MUTE_BUTTON:
                if !mute.getSnareMuteState() && snooze.getSnareSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                    snareMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.SNARE_IMAGE_ACTIVE), for: .normal)
                    for snareBeatCard in Range(0...3) {
                        snareBeatCardButtonArray[snareBeatCard]?.setImage(UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel()), for: .normal)
                            
                    }
                    snooze.changeSnoozeState(instrument: K.SnoozeConstants.SNARE_SNOOZE_BUTTON)
                       
                        
                } else if mute.getSnareMuteState() && !snooze.getSnareSnoozeState() { // if it is not snoozed, and you want to mute, only mute. do not snooze.
                    snareMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.SNARE_IMAGE_MUTED), for: .normal)
                } else if !mute.getSnareMuteState() && !snooze.getSnareSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                    snareMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.SNARE_IMAGE_ACTIVE), for: .normal)
                }
                
            case K.MuteConstants.MuteButtonNames.KICK_MUTE_BUTTON:
                if !mute.getKickMuteState() && snooze.getKickSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                    kickMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.KICK_IMAGE_ACTIVE), for: .normal)
                        for bassBeatCard in Range(0...3) {
                            kickBeatCardButtonArray[bassBeatCard]?.setImage(UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel()), for: .normal)
                            
                        }
                        snooze.changeSnoozeState(instrument: K.SnoozeConstants.BASS_SNOOZE_BUTTON)
                       
                        
                    } else if mute.getKickMuteState() && !snooze.getKickSnoozeState() { // if it is not snoozed, and you want to mute, only mute. do not snooze.
                        kickMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.KICK_IMAGE_MUTED), for: .normal)
                    } else if !mute.getKickMuteState() && !snooze.getKickSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                        kickMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.KICK_IMAGE_ACTIVE), for: .normal)
                }
                
            case K.MuteConstants.MuteButtonNames.HAT_MUTE_BUTTON:
                if !mute.getHatMuteState() && snooze.getHatSnoozeState() { // if it is snoozed already, and you want to unmute. unsnooze and unmute.
                        
                    hatMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.HAT_IMAGE_ACTIVE), for: .normal)
                    for hiHatBeatCard in Range(0...3) {
                        hatBeatCardButtonArray[hiHatBeatCard]?.setImage(UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel()), for: .normal)
                            
                    }
                    snooze.changeSnoozeState(instrument: K.SnoozeConstants.HI_HAT_SNOOZE_BUTTON)
                       
                        
                } else if mute.getHatMuteState() && !snooze.getHatSnoozeState() { // if it is not snoozed, and you want to mute, only mute. do not snooze.
                    hatMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.HAT_IMAGE_MUTED), for: .normal)
                } else if !mute.getHatMuteState() && !snooze.getHatSnoozeState() { // if it is not snoozed, and you want to unmute, simply unmute.
                    hatMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.HAT_IMAGE_ACTIVE), for: .normal)
                }
                
            default:
                print("error, sender.currentTitle case not found")
            }
        } else {
            print("Error: no sender title exists")
        }
    }
    
    // MARK: - Unmute UI
    func unmuteUI() {
        rideMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.RIDE_IMAGE_ACTIVE), for: .normal)
        snareMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.SNARE_IMAGE_ACTIVE), for: .normal)
        kickMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.KICK_IMAGE_ACTIVE), for: .normal)
        hatMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.HAT_IMAGE_ACTIVE), for: .normal)
        
        print("unmuteUI() called")
    }
    
    // MARK: - Snoozing
    
    @IBAction func snoozeButtonPressed(_ sender: UIButton) {
        
        if sender.currentTitle != nil {
            snooze.changeSnoozeState(instrument: sender.currentTitle!)
            print("Snooze Button Sender: \(sender.currentTitle!)")
            
            switch sender.currentTitle {
            case K.SnoozeConstants.RIDE_SNOOZE_BUTTON:
                if mute.getRideMuteState() && snooze.getRideSnoozeState() { // if it is already muted, and you want to snooze, simply snooze.
                        
                    ride0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    ride1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    ride2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    ride3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                        
                } else if !mute.getRideMuteState() && snooze.getRideSnoozeState() { // if it is not muted, and you want to snooze, mute and snooze. //change persist variable to false
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.RIDE_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    rideMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.RIDE_IMAGE_MUTED), for: .normal)
                    ride0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    ride1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    ride2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    ride3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    
                } else if mute.getRideMuteState() && !snooze.getRideSnoozeState() { // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                        
                    for rideBeatCard in Range(0...3) {
                        rideBeatCardButtonArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
                    }
                        
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.RIDE_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    rideMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.RIDE_IMAGE_ACTIVE), for: .normal)
    
                }
                
            case K.SnoozeConstants.SNARE_SNOOZE_BUTTON:
                if mute.getSnareMuteState() && snooze.getSnareSnoozeState() { // if it is already muted, and you want to snooze, simply snooze.
                                    
                    snare0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    snare1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    snare2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    snare3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                                    
                } else if !mute.getSnareMuteState() && snooze.getSnareSnoozeState() { // if it is not muted, and you want to snooze, mute and snooze.
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.SNARE_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    snareMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.SNARE_IMAGE_MUTED), for: .normal)
                    snare0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    snare1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    snare2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    snare3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                                
                } else if mute.getSnareMuteState() && !snooze.getSnareSnoozeState() { // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                    for snareBeatCard in Range(0...3) {
                        snareBeatCardButtonArray[snareBeatCard]?.setImage(UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel()), for: .normal)
                    }
                                    
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.SNARE_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    snareMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.SNARE_IMAGE_ACTIVE), for: .normal)
                
                }
                
            case K.SnoozeConstants.BASS_SNOOZE_BUTTON:
                if mute.getKickMuteState() && snooze.getKickSnoozeState() { // if it is already muted, and you want to snooze, simply snooze.
                                    
                    kick0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    kick1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    kick2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    kick3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal) 
                                    
                } else if !mute.getKickMuteState() && snooze.getKickSnoozeState() { // if it is not muted, and you want to snooze, mute and snooze.
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.KICK_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    kickMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.KICK_IMAGE_MUTED), for: .normal)
                    kick0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    kick1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    kick2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    kick3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                                
                } else if mute.getKickMuteState() && !snooze.getKickSnoozeState() { // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                    for bassBeatCard in Range(0...3) {
                        kickBeatCardButtonArray[bassBeatCard]?.setImage(UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel()), for: .normal)
                    }
                                    
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.KICK_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    kickMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.KICK_IMAGE_ACTIVE), for: .normal)
                
                }
                
            case K.SnoozeConstants.HI_HAT_SNOOZE_BUTTON:
                if mute.getHatMuteState() && snooze.getHatSnoozeState() { // if it is already muted, and you want to snooze, simply snooze.
                                    
                    hat0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    hat1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    hat2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    hat3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                                    
                } else if !mute.getHatMuteState() && snooze.getHatSnoozeState() { // if it is not muted, and you want to snooze, mute and snooze. \
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.HAT_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    hatMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.HAT_IMAGE_MUTED), for: .normal)
                    hat0.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    hat1.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    hat2.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                    hat3.setImage(#imageLiteral(resourceName: "Snoozed Beat Card"), for: .normal)
                                
                } else if mute.getHatMuteState() && !snooze.getHatSnoozeState() { // if it is both snoozed and muted, and you want to unsnooze, unsnooze and unmute.
                                    
                    for hiHatBeatCard in Range(0...3) {
                        hatBeatCardButtonArray[hiHatBeatCard]?.setImage(UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel()), for: .normal)
                    }
                                    
                    mute.changeMuteState(instrument: K.MuteConstants.MuteButtonNames.HAT_MUTE_BUTTON)
                    drumSounds.assignDrumSounds()
                    hatMuteOutlet.setImage(#imageLiteral(resourceName: K.MuteConstants.MuteImageNames.HAT_IMAGE_ACTIVE), for: .normal)
                
                }
                
            default:
                print("Error: snooze button title not matched")
            }
        
        } else {
            print("Snooze: sender.currentTitle is nil")
        }
        
    }
    
    // MARK: - Unsnooze
    
    func unsnoozeUI () {
        
        for rideBeatCard in Range(0...3) {
            rideBeatCardButtonArray[rideBeatCard]?.setImage(UIImage(named: wholeBeat.getRidePattern()[rideBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for snareBeatCard in Range(0...3) {
            snareBeatCardButtonArray[snareBeatCard]?.setImage(UIImage(named: wholeBeat.getSnarePattern()[snareBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for bassBeatCard in Range(0...3) {
        kickBeatCardButtonArray[bassBeatCard]?.setImage(UIImage(named: wholeBeat.getBassPattern()[bassBeatCard].getBeatCardLabel()), for: .normal)
        }
        
        for hiHatBeatCard in Range(0...3) {
            hatBeatCardButtonArray[hiHatBeatCard]?.setImage(UIImage(named: wholeBeat.getHiHatPattern()[hiHatBeatCard].getBeatCardLabel()), for: .normal)
        }
    }
    
    // MARK: - reset
    func resetPlaySettings() {
        if playBackEngine.getIsPlaying() {
            metronome.stopMetronome()
            drumSounds.stopDrumsSounds()
            _ = playBackEngine.changeIsPlaying()
            playButtonOutlet.setImage(#imageLiteral(resourceName: K.PlayPanelImageNames.PLAY), for: .normal)
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

//MARK: - TransparentThumbSlider


