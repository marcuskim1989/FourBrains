//
//  WholeBeat.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class WholeBeat {
    private var ridePattern: [BeatCard]
    private var snarePattern: [BeatCard]
    private var bassPattern: [BeatCard]
    private var hiHatPattern: [BeatCard]
    
    init(ridePattern: [BeatCard], snarePattern: [BeatCard], bassPattern: [BeatCard], hiHatPattern: [BeatCard]) {
        self.ridePattern = ridePattern
        self.snarePattern = snarePattern
        self.bassPattern = bassPattern
        self.hiHatPattern = hiHatPattern
    }
    
    public func getRidePattern() -> [BeatCard] {
        return ridePattern
    }
    
    public func getSnarePattern() -> [BeatCard] {
        return snarePattern
    }
    
    public func getBassPattern() -> [BeatCard] {
        return bassPattern
    }
    
    public func getHiHatPattern() -> [BeatCard] {
        return hiHatPattern
    }
}
