//
//  Metronome.swift
//  Four Brains
//
//  Created by Marcus Kim on 1/28/20.
//  Copyright © 2020 Marcus Kim. All rights reserved.
//

import Foundation
import AudioKit
import AudioKitUI

    let metronome = AKMetronome()
    let view = LiveView()

    metronome.callback = {
        view.beatFlasher.color = .white

        DispatchQueue.main.async {
        view.beatFlasher.needsDisplay = true
    }

    let deadlineTime = DispatchTime.now() + (60 / metronome.tempo) / 10.0
    
    DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
        view.beatFlasher.color = .red
    }
}

AudioKit.output = metronome
try AudioKit.start()
metronome.start()


class LiveView: AKLiveViewController {

    var beatFlasher: AKButton!

    override func viewDidLoad() {
        addTitle("Metronome")

        beatFlasher = AKButton(title: "Stop", color: AKColor.red) { button in
            if metronome.isPlaying {
                button.title = "Start"
                button.color = #colorLiteral(red: 0, green: 0.5859588462, blue: 0, alpha: 1)
                metronome.stop()
                metronome.reset()
            } else {
                button.title = "Stop"
                button.color = .red
                metronome.reset()
                metronome.restart()
            }
        }

        addView(beatFlasher)

        addView(AKSlider(property: "Subdivision", value: 4, range: 1 ... 10, format: "%0.0f") { sliderValue in
            metronome.subdivision = Int(round(sliderValue))
        })

        addView(AKSlider(property: "Tempo", value: 60, range: 40 ... 240, format: "%0.1f BPM") { sliderValue in
            metronome.tempo = sliderValue
        })

        addView(AKSlider(property: "Frequency 1", value: 2_000, range: 200 ... 4_000, format: "%0.0f Hz") { sliderValue in
            metronome.frequency1 = sliderValue
        })

        addView(AKSlider(property: "Frequency 2", value: 1_000, range: 200 ... 4_000, format: "%0.0f Hz") { sliderValue in
            metronome.frequency2 = sliderValue
        })
    }
}
