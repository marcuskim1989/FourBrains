//
//  BeatCard.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/5/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit

class BeatCard {
    var beatCardLabel: String
    var beatCardNoteSequence: [Int]
    
    init(l: String, ns: [Int]){
        beatCardLabel = l
        beatCardNoteSequence = ns
    }
    
}
