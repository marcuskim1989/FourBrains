//
//  SelectBeatCards.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 6/12/22.
//  Copyright © 2022 Marcus Kim. All rights reserved.
//

import UIKit
import AudioKit
import HGCircularSlider
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
                case K.BeatCardNoteStrings.BEAT_CARD_1A_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1A"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_1B_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1B"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_1C_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1C"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_1D_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "1D"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_2A_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2A"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_2B_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2B"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_2C_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2C"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_2D_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2D"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_2E_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2E"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_2F_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "2F"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_3A_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3A"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_3B_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3B"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_3C_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3C"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_3D_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "3D"), for: .normal)
                case K.BeatCardNoteStrings.BEAT_CARD_4_NOTE_STRING:
                    sender.setImage(#imageLiteral(resourceName: "4"), for: .normal)
                default:
                    sender.setImage(#imageLiteral(resourceName: "Beat Card Box"), for: .normal)
                }
                
                
            }
        }
        
    }
}
