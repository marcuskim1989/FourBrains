//
//  WholeBeat.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class WholeBeat {
    
    var ridePattern: [BeatCard]
    var snarePattern: [BeatCard]
    var bassPattern: [BeatCard]
    var hiHatPattern: [BeatCard]
    
    init(ridePattern: [BeatCard], snarePattern: [BeatCard], bassPattern: [BeatCard], hiHatPattern: [BeatCard])
    {
        self.ridePattern = ridePattern
        self.snarePattern = snarePattern
        self.bassPattern = bassPattern
        self.hiHatPattern = hiHatPattern
    }
    
}
