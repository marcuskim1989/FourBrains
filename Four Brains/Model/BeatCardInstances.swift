//
//  BeatCardInstances.swift
//  Four Brains
//
//  Created by Marcus Kim on 2/23/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation

class BeatCardInstances {
    let beatCard0 = BeatCard(l: "0", ns: [0,0,0,0])
    let beatCard1A = BeatCard(l: "1A", ns: [1,0,0,0])
    let beatCard1B = BeatCard(l: "1B", ns: [0,1,0,0])
    let beatCard1C = BeatCard(l: "1C", ns: [0,0,1,0])
    let beatCard1D = BeatCard(l: "1D", ns: [0,0,0,1])
    let beatCard2A = BeatCard(l: "2A", ns: [1,1,0,0])
    let beatCard2B = BeatCard(l: "2B", ns: [0,1,1,0])
    let beatCard2C = BeatCard(l: "2C", ns: [0,0,1,1])
    let beatCard2D = BeatCard(l: "2D", ns: [1,0,0,1])
    let beatCard2E = BeatCard(l: "2E", ns: [1,0,1,0])
    let beatCard2F = BeatCard(l: "2F", ns: [0,1,0,1])
    let beatCard3A = BeatCard(l: "3A", ns: [1,1,1,0])
    let beatCard3B = BeatCard(l: "3B", ns: [1,1,0,1])
    let beatCard3C = BeatCard(l: "3C", ns: [1,0,1,1])
    let beatCard3D = BeatCard(l: "3D", ns: [0,1,1,1])
    let beatCard4 = BeatCard(l: "4", ns: [1,1,1,1])
    
    var beatCardArray: [BeatCard]
    
    init() {
        beatCardArray = [beatCard0,
                         beatCard1A, beatCard1B, beatCard1C, beatCard1D,
                         beatCard2A, beatCard2B, beatCard2C, beatCard2D, beatCard2E, beatCard2F,
                         beatCard3A, beatCard3B, beatCard3C, beatCard3D,
                         beatCard4]
    }
    
}
