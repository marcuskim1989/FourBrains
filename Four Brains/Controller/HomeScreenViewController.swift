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
    
    @IBOutlet weak var playButtonOutlet: UIButton!
    @IBOutlet weak var metronomeOutlet: UIButton!
    @IBOutlet weak var bpmAdjustAccessButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        metronome = Metronome()
        drumSounds = DrumSounds()
        playBackEngine = PlayBackEngine(metronome: metronome, drumSounds: drumSounds)
        randomization = Randomization()
        beatCardInstances = BeatCardInstances()
        
        do {
            try AudioKit.start()
        } catch {
            print("AudioKit did not start.")
        }
        
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
        playBackEngine.play(metronome: metronome, drumSounds: drumSounds)
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
       
        
        /*
        if playBackEngine.isPlaying && !metronome.metronomeToggleState{
            metronome.metronome.stop()
        } else if playBackEngine.isPlaying && metronome.metronomeToggleState {
            metronome.metronome.start()
        }
        */
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
        if playBackEngine.isPlaying == true {
            metronome.metronome.stop()
            metronome.metronome.reset()
            drumSounds.sequencer.stop()
            drumSounds.sequencer.rewind()
            playBackEngine.changeIsPlaying()
            playButtonOutlet.setImage(#imageLiteral(resourceName: "Play Button"), for: .normal)
        }
    }
    
    //MARK: randomize beat card images
    
    @IBAction func randomizationButtonPressed(_ sender: Any) {
        
        let wholeBeat: WholeBeat = randomization.randomize(beatCardInstances: self.beatCardInstances, drumSounds: self.drumSounds)
        
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
        
        /*
        for beatCardView in beatCardImageOutletArray {
            beatCardView?.image = beatCardImageArray[Int.random(in: 0...15)]
            
        }
        */
        
    }
 
}

