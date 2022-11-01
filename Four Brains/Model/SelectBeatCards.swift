//
//  SelectBeatCards.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 6/12/22.
//  Copyright © 2022 Marcus Kim. All rights reserved.
//

import UIKit
import AudioKit
import McPicker

extension HomeScreenViewController {
    
    func selectBeatCards(sender: UIButton) {
        
        let mcPicker: McPicker = McPicker(data: K.BeatCardNoteStrings.BEAT_CARD_STRING_ARRAY)
        
        let customLabel: UILabel = UILabel()
        customLabel.textAlignment = .center
        customLabel.textColor = .black
        customLabel.font = UIFont(name: "Helvetica Light", size: 40)
        mcPicker.label = customLabel
        
        let fixedSpace: McPickerBarButtonItem = McPickerBarButtonItem.fixedSpace(width: 10.0)
        let flexibleSpace: McPickerBarButtonItem = McPickerBarButtonItem.flexibleSpace()
        let fireButton: McPickerBarButtonItem = McPickerBarButtonItem.done(mcPicker: mcPicker, title: "Done") // Set custom Text
        let cancelButton: McPickerBarButtonItem = McPickerBarButtonItem.cancel(mcPicker: mcPicker, barButtonSystemItem: .cancel) // or system items
        mcPicker.setToolbarItems(items: [fixedSpace, cancelButton, flexibleSpace, fireButton, fixedSpace])

        mcPicker.toolbarButtonsColor = .black
        mcPicker.toolbarBarTintColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        mcPicker.pickerBackgroundColor = .clear
        mcPicker.backgroundColor = .clear
        mcPicker.backgroundColorAlpha = 0.25

        
        mcPicker.showAsPopover(fromViewController: self, sourceView: sender) { (selections: [Int: String]) -> Void in
            if let beatCardNoteString: String = selections[0] {
                
                switch beatCardNoteString {
                case K.BeatCardNoteStrings.BEAT_CARD_0_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "0"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_1A_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1A"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_1B_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1B"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_1C_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1C"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_1D_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1D"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_2A_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2A"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_2B_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2B"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_2C_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2C"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_2D_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2D"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_2E_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2E"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_2F_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2F"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_3A_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3A"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_3B_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3B"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_3C_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3C"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_3D_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3D"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                case K.BeatCardNoteStrings.BEAT_CARD_4_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "4"), for: .normal)
                    self.rebuildBeatWithSelection(beatCardNoteString, sender: sender)
                default:
                    sender.setImage(#imageLiteral(resourceName: "Beat Card Box"), for: .normal)
                }
                
                
            }
        }
        
    }
    
    // pass the selected beat card string to this function, use the beat card string to pull a BeatCard object and place it into a new whole Beat
    func rebuildBeatWithSelection(_ selectedBeatCard: String, sender: UIButton) {
        
        print("selectedBeatCard is", selectedBeatCard, "with index", "\(String(describing: K.BeatCardNoteStrings.BEAT_CARD_STRING_INDEXES[selectedBeatCard]))")
            let index = K.BeatCardNoteStrings.BEAT_CARD_STRING_INDEXES[selectedBeatCard]
        
        switch sender.tag {
            case 1:
                self.wholeBeat.ridePattern[0] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 2:
                self.wholeBeat.ridePattern[1] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 3:
                self.wholeBeat.ridePattern[2] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 4:
                self.wholeBeat.ridePattern[3] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 5:
                self.wholeBeat.snarePattern[0] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 6:
                self.wholeBeat.snarePattern[1] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 7:
                self.wholeBeat.snarePattern[2] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 8:
                self.wholeBeat.snarePattern[3] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 9:
                self.wholeBeat.kickPattern[0] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 10:
                self.wholeBeat.kickPattern[1] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 11:
                self.wholeBeat.kickPattern[2] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 12:
                self.wholeBeat.kickPattern[3] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 13:
                self.wholeBeat.hatPattern[0] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 14:
                self.wholeBeat.hatPattern[1] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 15:
                self.wholeBeat.hatPattern[2] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            case 16:
                self.wholeBeat.hatPattern[3] = getBeatCardInstances().BEAT_CARD_ARRAY[index ?? 0]
            default:
                print("tag not found")
            
            
        }
        drumSounds.processDrumSounds(wholeBeat: self.wholeBeat)
        playBackEngine.play()
        
        
    }
    
}
