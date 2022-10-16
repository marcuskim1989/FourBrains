//
//  MetronomeViewController.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/12/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import UIKit
import Foundation
import HGCircularSlider

protocol BPMAdjustorDelegate: AnyObject {
    func updateBPM(BPM: Int)
}

class BPMAdjustorViewController: UIViewController {

    @IBOutlet weak var bpmAdjustor: CircularSlider!
    
    public var currentBPM: Int?
    public weak var delegate: BPMAdjustorDelegate?
    @IBOutlet weak var bpmLabel: UILabel!
    override var prefersHomeIndicatorAutoHidden: Bool {
        true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        bpmAdjustor.addTarget(self, action: #selector(updateAdjustorBPM), for: .valueChanged)
        
        bpmAdjustor.trackColor = .white
        bpmAdjustor.maximumValue = 240.0
        
        if self.currentBPM != nil {
            print("currentBPM is \(self.currentBPM!)")
            bpmAdjustor.endPointValue = CGFloat(self.currentBPM!)
            
        } else {
            print("currentBPM == nil")
        }
        
        if delegate != nil {
            print("delegate is not nil")
        } else {
            print("delegate is nil")
        }
        
        updateAdjustorBPM()
        
    }
    
    public func setDelegate(_ homeScreenViewController: BPMAdjustorDelegate) {
        delegate = homeScreenViewController
    }
    
    public func setCurrentBPM(_ currentBPM: Int) {
        self.currentBPM = currentBPM
        print("inside setCurrentBPM: currentBPM is \(currentBPM)")
    }
    
    
    @objc func updateAdjustorBPM() {
        
        bpmLabel.text = String(Int(bpmAdjustor.endPointValue))
        currentBPM = Int(bpmAdjustor.endPointValue)

    }
    
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        
        if delegate != nil && currentBPM != nil {
            delegate?.updateBPM(BPM: self.currentBPM!)
            if self.currentBPM != nil {
                print("chosen bpm is: \(self.currentBPM!)")
            }
        } else if delegate == nil {
            print("delegate is nil")
        } else if currentBPM == nil {
            print("currentBPM is nil")
        }
         
        self.dismiss(animated: true, completion: nil)
        // print(currentBPM)
        
    }

}
