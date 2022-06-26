//
//  WholeBeat.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

 class WholeBeat {
    internal var ridePattern: [BeatCard]
    internal var snarePattern: [BeatCard]
    internal var kickPattern: [BeatCard]
    internal var hatPattern: [BeatCard]
    
    init(ridePattern: [BeatCard], snarePattern: [BeatCard], bassPattern: [BeatCard], hiHatPattern: [BeatCard]) {
        self.ridePattern = ridePattern
        self.snarePattern = snarePattern
        self.kickPattern = bassPattern
        self.hatPattern = hiHatPattern
    }
    
    public func getRidePattern() -> [BeatCard] {
        return ridePattern
    }
    
    public func getSnarePattern() -> [BeatCard] {
        return snarePattern
    }
    
    public func getBassPattern() -> [BeatCard] {
        return kickPattern
    }
    
    public func getHiHatPattern() -> [BeatCard] {
        return hatPattern
    }
}
