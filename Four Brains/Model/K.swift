//
//  K.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 4/5/21.
//  Copyright © 2021 Marcus Kim. All rights reserved.
//

import Foundation
import Collections

enum K {
    enum MuteConstants {
        enum MuteButtonNames {
            static let RIDE_MUTE_BUTTON: String = "ride_mute_button"
            static let SNARE_MUTE_BUTTON: String = "snare_mute_button"
            static let KICK_MUTE_BUTTON: String = "kick_mute_button"
            static let HAT_MUTE_BUTTON: String = "hat_mute_button"
        }
        
        enum MuteImageNames {
            static let RIDE_IMAGE_ACTIVE: String = "Ride Active"
            static let RIDE_IMAGE_MUTED: String = "Ride Muted"
            static let SNARE_IMAGE_ACTIVE: String = "Snare Active"
            static let SNARE_IMAGE_MUTED: String = "Snare Muted"
            static let KICK_IMAGE_ACTIVE: String = "Kick Active"
            static let KICK_IMAGE_MUTED: String = "Kick Muted"
            static let HAT_IMAGE_ACTIVE: String = "Hat Active"
            static let HAT_IMAGE_MUTED: String = "Hat Muted"
        }
    }
    
    enum SnoozeConstants {
        static let RIDE_SNOOZE_BUTTON: String = "ride_snooze_button"
        static let SNARE_SNOOZE_BUTTON: String = "snare_snooze_button"
        static let BASS_SNOOZE_BUTTON: String = "bass_snooze_button"
        static let HI_HAT_SNOOZE_BUTTON: String = "hi_hat_snooze_button"
    }
    
    enum PlayPanelImageNames {
        static let PROFILE: String = "Profile"
        static let PLAY: String = "Play"
        static let STOP: String = "Stop"
        static let METRONOME_ACTIVE: String = "Metronome Active"
        static let METRONOME_MUTED: String = "Metronome Muted"
        static let SUBDIVISION_4TH: String = "4th"
        static let SUBDIVISION_8TH: String = "8th"
        static let SUBDIVISION_16TH: String = "16th"
        static let RANDOM: String = "Random"
    }
    
    enum DrumSoundFileNames {
        static let RIDE_FILE_NAME: String = "open_hi_hat_A#1"
        static let SNARE_FILE_NAME: String = "snare_D1"
        static let BASS_FILE_NAME: String = "bass_drum_C1"
        static let HI_HAT_FILE_NAME: String = "closed_hi_hat_F#1"
    }
    
    class BeatCardInstances {
        static let BEAT_CARD_0: BeatCard = BeatCard(label: "0", noteSequence: [0, 0, 0, 0])
        static let BEAT_CARD_1A: BeatCard = BeatCard(label: "1A", noteSequence: [1, 0, 0, 0])
        static let BEAT_CARD_1B: BeatCard = BeatCard(label: "1B", noteSequence: [0, 1, 0, 0])
        static let BEAT_CARD_1C: BeatCard = BeatCard(label: "1C", noteSequence: [0, 0, 1, 0])
        static let BEAT_CARD_1D: BeatCard = BeatCard(label: "1D", noteSequence: [0, 0, 0, 1])
        static let BEAT_CARD_2A: BeatCard = BeatCard(label: "2A", noteSequence: [1, 1, 0, 0])
        static let BEAT_CARD_2B: BeatCard = BeatCard(label: "2B", noteSequence: [0, 1, 1, 0])
        static let BEAT_CARD_2C: BeatCard = BeatCard(label: "2C", noteSequence: [0, 0, 1, 1])
        static let BEAT_CARD_2D: BeatCard = BeatCard(label: "2D", noteSequence: [1, 0, 0, 1])
        static let BEAT_CARD_2E: BeatCard = BeatCard(label: "2E", noteSequence: [1, 0, 1, 0])
        static let BEAT_CARD_2F: BeatCard = BeatCard(label: "2F", noteSequence: [0, 1, 0, 1])
        static let BEAT_CARD_3A: BeatCard = BeatCard(label: "3A", noteSequence: [1, 1, 1, 0])
        static let BEAT_CARD_3B: BeatCard = BeatCard(label: "3B", noteSequence: [1, 1, 0, 1])
        static let BEAT_CARD_3C: BeatCard = BeatCard(label: "3C", noteSequence: [1, 0, 1, 1])
        static let BEAT_CARD_3D: BeatCard = BeatCard(label: "3D", noteSequence: [0, 1, 1, 1])
        static let BEAT_CARD_4: BeatCard = BeatCard(label: "4", noteSequence: [1, 1, 1, 1])
        
        var BEAT_CARD_ARRAY: [BeatCard]
        
        init() {
            BEAT_CARD_ARRAY = [
                K.BeatCardInstances.BEAT_CARD_0,
                K.BeatCardInstances.BEAT_CARD_1A,
                K.BeatCardInstances.BEAT_CARD_1B,
                K.BeatCardInstances.BEAT_CARD_1C,
                K.BeatCardInstances.BEAT_CARD_1D,
                K.BeatCardInstances.BEAT_CARD_2A,
                K.BeatCardInstances.BEAT_CARD_2B,
                K.BeatCardInstances.BEAT_CARD_2C,
                K.BeatCardInstances.BEAT_CARD_2D,
                K.BeatCardInstances.BEAT_CARD_2E,
                K.BeatCardInstances.BEAT_CARD_2F,
                K.BeatCardInstances.BEAT_CARD_3A,
                K.BeatCardInstances.BEAT_CARD_3B,
                K.BeatCardInstances.BEAT_CARD_3C,
                K.BeatCardInstances.BEAT_CARD_3D,
                K.BeatCardInstances.BEAT_CARD_4
            ]
        }
        
    }
    
    enum BeatCardNoteStrings {
        static let BEAT_CARD_0_NOTE_STRING: String = "- - - -"
        static let BEAT_CARD_1A_NOTE_STRING: String = "X - - -"
        static let BEAT_CARD_1B_NOTE_STRING: String = "- X - -"
        static let BEAT_CARD_1C_NOTE_STRING: String = "- - X -"
        static let BEAT_CARD_1D_NOTE_STRING: String = "- - - X"
        static let BEAT_CARD_2A_NOTE_STRING: String = "X X - -"
        static let BEAT_CARD_2B_NOTE_STRING: String = "- X X -"
        static let BEAT_CARD_2C_NOTE_STRING: String = "- - X X"
        static let BEAT_CARD_2D_NOTE_STRING: String = "X - - X"
        static let BEAT_CARD_2E_NOTE_STRING: String = "X - X -"
        static let BEAT_CARD_2F_NOTE_STRING: String = "- X - X"
        static let BEAT_CARD_3A_NOTE_STRING: String = "X X X -"
        static let BEAT_CARD_3B_NOTE_STRING: String = "X X - X"
        static let BEAT_CARD_3C_NOTE_STRING: String = "X - X X"
        static let BEAT_CARD_3D_NOTE_STRING: String = "- X X X"
        static let BEAT_CARD_4_NOTE_STRING: String = "X X X X"
        
        static let BEAT_CARD_STRING_ARRAY: [[String]] = [
            [
                BEAT_CARD_0_NOTE_STRING,
                BEAT_CARD_1A_NOTE_STRING,
                BEAT_CARD_1B_NOTE_STRING,
                BEAT_CARD_1C_NOTE_STRING,
                BEAT_CARD_1D_NOTE_STRING,
                BEAT_CARD_2A_NOTE_STRING,
                BEAT_CARD_2B_NOTE_STRING,
                BEAT_CARD_2C_NOTE_STRING,
                BEAT_CARD_2D_NOTE_STRING,
                BEAT_CARD_2E_NOTE_STRING,
                BEAT_CARD_2F_NOTE_STRING,
                BEAT_CARD_3A_NOTE_STRING,
                BEAT_CARD_3B_NOTE_STRING,
                BEAT_CARD_3C_NOTE_STRING,
                BEAT_CARD_3D_NOTE_STRING,
                BEAT_CARD_4_NOTE_STRING
            ]
        ]
        
        static let BEAT_CARD_STRING_INDEXES: OrderedDictionary = [
        
            BEAT_CARD_0_NOTE_STRING: 0,
            BEAT_CARD_1A_NOTE_STRING: 1,
            BEAT_CARD_1B_NOTE_STRING: 2,
            BEAT_CARD_1C_NOTE_STRING: 3,
            BEAT_CARD_1D_NOTE_STRING: 4,
            BEAT_CARD_2A_NOTE_STRING: 5,
            BEAT_CARD_2B_NOTE_STRING: 6,
            BEAT_CARD_2C_NOTE_STRING: 7,
            BEAT_CARD_2D_NOTE_STRING: 8,
            BEAT_CARD_2E_NOTE_STRING: 9,
            BEAT_CARD_2F_NOTE_STRING: 10,
            BEAT_CARD_3A_NOTE_STRING: 11,
            BEAT_CARD_3B_NOTE_STRING: 12,
            BEAT_CARD_3C_NOTE_STRING: 13,
            BEAT_CARD_3D_NOTE_STRING: 14,
            BEAT_CARD_4_NOTE_STRING: 15,
        
        ]
        
    }
}
