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
   
    var currentBPM: Int?
    weak var delegate: BPMAdjustorDelegate?
    @IBOutlet weak var bpmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentBPM != nil {
            print("currentBPM is \(currentBPM!)")
           bpmAdjustor.endPointValue = CGFloat(currentBPM!)
            
        } else {
            print("currentBPM == nil")
        }
        
        if delegate != nil {
            print("delegate is not nil")
        } else {
            print("delegate is nil")
        }
        
        updateAdjustorBPM()
        
        bpmAdjustor.addTarget(self, action: #selector(updateAdjustorBPM), for: .valueChanged)
    }
    @objc func updateAdjustorBPM() {
       bpmLabel.text = String(format: "%.0f", bpmAdjustor.endPointValue)
        
       currentBPM = Int(bpmAdjustor.endPointValue)
    }
    
    
    
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        
        if delegate != nil && currentBPM != nil {
            delegate?.updateBPM(BPM: currentBPM!)
        } else if delegate == nil{
            print("delegate is nil")
        } else if currentBPM == nil {
            print("currentBPM is nil")
        }
         
        self.dismiss(animated: true, completion: nil)
        //print(currentBPM)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
