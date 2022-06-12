//
//  K.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 4/5/21.
//  Copyright © 2021 Marcus Kim. All rights reserved.
//

import Foundation

class K {
    class MuteConstants {
        class MuteButtonNames{
            static let RIDE_MUTE_BUTTON = "ride_mute_button"
            static let SNARE_MUTE_BUTTON = "snare_mute_button"
            static let KICK_MUTE_BUTTON = "kick_mute_button"
            static let HAT_MUTE_BUTTON = "hat_mute_button"
        }
        
        class MuteImageNames{
            static let RIDE_IMAGE_ACTIVE = "Ride Active"
            static let RIDE_IMAGE_MUTED = "Ride Muted"
            static let SNARE_IMAGE_ACTIVE = "Snare Active"
            static let SNARE_IMAGE_MUTED = "Snare Muted"
            static let KICK_IMAGE_ACTIVE = "Kick Active"
            static let KICK_IMAGE_MUTED = "Kick Muted"
            static let HAT_IMAGE_ACTIVE = "Hat Active"
            static let HAT_IMAGE_MUTED = "Hat Muted"
        }
    }
    
    class SnoozeConstants {
        static let RIDE_SNOOZE_BUTTON = "ride_snooze_button"
        static let SNARE_SNOOZE_BUTTON = "snare_snooze_button"
        static let BASS_SNOOZE_BUTTON = "bass_snooze_button"
        static let HI_HAT_SNOOZE_BUTTON = "hi_hat_snooze_button"
    }
    
    class PlayPanelImageNames {
        static let PROFILE = "Profile"
        static let PLAY = "Play"
        static let STOP = "Stop"
        static let METRONOME_ACTIVE = "Metronome Active"
        static let METRONOME_MUTED = "Metronome Muted"
        static let SUBDIVISION_4TH = "4th"
        static let SUBDIVISION_8TH = "8th"
        static let SUBDIVISION_16TH = "16th"
        static let RANDOM = "Random"
    }
    
    class DrumSoundFileNames {
        static let RIDE_FILE_NAME = "open_hi_hat_A#1"
        static let SNARE_FILE_NAME = "snare_D1"
        static let BASS_FILE_NAME = "bass_drum_C1"
        static let HI_HAT_FILE_NAME = "closed_hi_hat_F#1"
    }
    
    class BeatCardInstances {
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
        
        var BEAT_CARD_ARRAY: [BeatCard]
        
        
        init() {
            BEAT_CARD_ARRAY = [K.BeatCardInstances.BEAT_CARD_0,
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
                               K.BeatCardInstances.BEAT_CARD_4]
        }
        
    }
    
    class BeatCardNoteStrings {
        static let BEAT_CARD_0_NOTE_STRING = "- - - -"
        static let BEAT_CARD_1A_NOTE_STRING = "X - - -"
        static let BEAT_CARD_1B_NOTE_STRING = "- X - -"
        static let BEAT_CARD_1C_NOTE_STRING = "- - X -"
        static let BEAT_CARD_1D_NOTE_STRING = "- - - X"
        static let BEAT_CARD_2A_NOTE_STRING = "X X - -"
        static let BEAT_CARD_2B_NOTE_STRING = "- X X -"
        static let BEAT_CARD_2C_NOTE_STRING = "- - X X"
        static let BEAT_CARD_2D_NOTE_STRING = "X - - X"
        static let BEAT_CARD_2E_NOTE_STRING = "X - X -"
        static let BEAT_CARD_2F_NOTE_STRING = "- X - X"
        static let BEAT_CARD_3A_NOTE_STRING = "X X X -"
        static let BEAT_CARD_3B_NOTE_STRING = "X X - X"
        static let BEAT_CARD_3C_NOTE_STRING = "X - X X"
        static let BEAT_CARD_3D_NOTE_STRING = "- X X X"
        static let BEAT_CARD_4_NOTE_STRING = "X X X X"
        
        static let BEAT_CARD_STRING_ARRAY = [
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
        
    }
    
    
    
}
