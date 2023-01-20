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
    
    var timestampOfCreation: Date
    var timestampOfLastMod: Date
    var firstTimeCreated: Bool = true
    let timestamp: Double
    let myTimeInterval: TimeInterval
    let time: Date
    var beatName: String = "Funk Beat"
    
    enum CodingKeys: String, CodingKey {
        case ridePattern
        case snarePattern
        case kickPattern
        case hatPattern
        
        case timestampOfCreation
        case timestampOfLastMod
        case firstTimeCreated
        case timestamp
        case myTimeInterval
        case time
        case beatName
    }
    
    
    
    init(ridePattern: [BeatCard], snarePattern: [BeatCard], bassPattern: [BeatCard], hiHatPattern: [BeatCard]) {
        self.ridePattern = ridePattern
        self.snarePattern = snarePattern
        self.kickPattern = bassPattern
        self.hatPattern = hiHatPattern
        
        self.timestamp = Date().timeIntervalSince1970
        self.myTimeInterval = TimeInterval(timestamp)
        self.time = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
        self.timestampOfCreation = time
        self.timestampOfLastMod = time
        
        print("timestamp", time)
        print("timestampOfCreation", timestampOfCreation)
        print("timestampOfLastMod", timestampOfLastMod)
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
