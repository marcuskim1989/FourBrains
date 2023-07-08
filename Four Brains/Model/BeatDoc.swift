//
//  BeatDoc.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 2/15/23.
//  Copyright © 2023 Marcus Kim. All rights reserved.
//

import Foundation

class BeatDoc: Codable {
    
    var timestampOfCreation: Date
    var timestampOfLastMod: Date
    var firstTimeCreated: Bool = true
    let timestamp: Double
    let myTimeInterval: TimeInterval
    let time: Date
    var beatName: String = "BEAT"
    
    var wholeBeat: WholeBeat
    
    
    enum CodingKeys: String, CodingKey {
        
        case timestampOfCreation
        case timestampOfLastMod
        case firstTimeCreated
        case timestamp
        case myTimeInterval
        case time
        case beatName
        case wholeBeat
    }
    
    func setBeatName(beatName: String){
        
        if !beatName.isEmpty {
            self.beatName = beatName
        }
    }
    
    
    
    func getTime() -> Date {
        return time
    }
    
//    func doNotChangeTimestampOfCreation(timestamp: Date) {
//        timestampOfCreation = timestamp
//    }
    
    init(wholeBeat: WholeBeat) {
        
        self.wholeBeat = wholeBeat
        
        
        // TODO: don't set these upon init
        // only set these 
        self.timestamp = Date().timeIntervalSince1970
        self.myTimeInterval = TimeInterval(timestamp)
        self.time = Date(timeIntervalSince1970: TimeInterval(myTimeInterval))
        self.timestampOfCreation = time
        self.timestampOfLastMod = time
        
        print("timestamp", time)
        print("timestampOfCreation", timestampOfCreation)
        print("timestampOfLastMod", timestampOfLastMod)
    }
    
}
