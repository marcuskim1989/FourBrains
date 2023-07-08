//
//  WholeBeat.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class WholeBeat: Codable {
    internal var ridePattern: [BeatCard]
    internal var snarePattern: [BeatCard]
    internal var kickPattern: [BeatCard]
    internal var hatPattern: [BeatCard]
    
    
    
    enum CodingKeys: String, CodingKey {
        case ridePattern
        case snarePattern
        case kickPattern
        case hatPattern
        
    }
    
    
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
