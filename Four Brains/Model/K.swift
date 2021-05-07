//
//  K.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 4/5/21.
//  Copyright © 2021 Marcus Kim. All rights reserved.
//

import Foundation

class K {
    class MUTECONSTANTS {
        static let RIDE_MUTE_BUTTON = "ride_mute_button"
        static let SNARE_MUTE_BUTTON = "snare_mute_button"
        static let BASS_MUTE_BUTTON = "bass_mute_button"
        static let HI_HAT_MUTE_BUTTON = "hi_hat_mute_button"
    }
    
    class SNOOZECONSTANTS {
        static let RIDE_SNOOZE_BUTTON = "ride_snooze_button"
        static let SNARE_SNOOZE_BUTTON = "snare_snooze_button"
        static let BASS_SNOOZE_BUTTON = "bass_snooze_button"
        static let HI_HAT_SNOOZE_BUTTON = "hi_hat_snooze_button"
    }
    
    class DRUMSOUNDFILENAMES {
        static let RIDE_FILE_NAME = "open_hi_hat_A#1"
        static let SNARE_FILE_NAME = "snare_D1"
        static let BASS_FILE_NAME = "bass_drum_C1"
        static let HI_HAT_FILE_NAME = "closed_hi_hat_F#1"
    }
    
    class BEATCARDINSTANCES {
        static let BEAT_CARD_0 = BeatCard(label: "0", noteSequence: [0,0,0,0])
        static let BEAT_CARD_1A = BeatCard(label: "1A", noteSequence: [1,0,0,0])
        static let BEAT_CARD_1B = BeatCard(label: "1B", noteSequence: [0,1,0,0])
        static let BEAT_CARD_1C = BeatCard(label: "1C", noteSequence: [0,0,1,0])
        static let BEAT_CARD_1D = BeatCard(label: "1D", noteSequence: [0,0,0,1])
        static let BEAT_CARD_2A = BeatCard(label: "2A", noteSequence: [1,1,0,0])
        static let BEAT_CARD_2B = BeatCard(label: "2B", noteSequence: [0,1,1,0])
        static let BEAT_CARD_2C = BeatCard(label: "2C", noteSequence: [0,0,1,1])
        static let BEAT_CARD_2D = BeatCard(label: "2D", noteSequence: [1,0,0,1])
        static let BEAT_CARD_2E = BeatCard(label: "2E", noteSequence: [1,0,1,0])
        static let BEAT_CARD_2F = BeatCard(label: "2F", noteSequence: [0,1,0,1])
        static let BEAT_CARD_3A = BeatCard(label: "3A", noteSequence: [1,1,1,0])
        static let BEAT_CARD_3B = BeatCard(label: "3B", noteSequence: [1,1,0,1])
        static let BEAT_CARD_3C = BeatCard(label: "3C", noteSequence: [1,0,1,1])
        static let BEAT_CARD_3D = BeatCard(label: "3D", noteSequence: [0,1,1,1])
        static let BEAT_CARD_4 = BeatCard(label: "4", noteSequence: [1,1,1,1])
        
        var beatCardArray: [BeatCard]
        
        init() {
            beatCardArray = [K.BEATCARDINSTANCES.BEAT_CARD_0,
                             K.BEATCARDINSTANCES.BEAT_CARD_1A,
                             K.BEATCARDINSTANCES.BEAT_CARD_1B,
                             K.BEATCARDINSTANCES.BEAT_CARD_1C,
                             K.BEATCARDINSTANCES.BEAT_CARD_1D,
                             K.BEATCARDINSTANCES.BEAT_CARD_2A,
                             K.BEATCARDINSTANCES.BEAT_CARD_2B,
                             K.BEATCARDINSTANCES.BEAT_CARD_2C,
                             K.BEATCARDINSTANCES.BEAT_CARD_2D,
                             K.BEATCARDINSTANCES.BEAT_CARD_2E,
                             K.BEATCARDINSTANCES.BEAT_CARD_2F,
                             K.BEATCARDINSTANCES.BEAT_CARD_3A,
                             K.BEATCARDINSTANCES.BEAT_CARD_3B,
                             K.BEATCARDINSTANCES.BEAT_CARD_3C,
                             K.BEATCARDINSTANCES.BEAT_CARD_3D,
                             K.BEATCARDINSTANCES.BEAT_CARD_4]
        }
        
    }

}
