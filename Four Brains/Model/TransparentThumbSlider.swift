//
//  TransparentThumbSlider.swift
//  Four Brains
//
//  Created by Marcus Y. Kim on 10/23/22.
//  Copyright © 2022 Marcus Kim. All rights reserved.
//

import Foundation
import UIKit

class TransparentThumbSlider: UISlider {

    let thumbWidth: CGFloat = 25

    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    func configure() {
        setThumbImage(TransparentThumbSlider.thumbImage(diameter: thumbWidth, color: .black), for: .normal)

        addTarget(self, action: #selector(updateTrackImages), for: .valueChanged)

        print("transparentThumbSlider.configure() successfully called")
        updateTrackImages()
    }

    static func thumbImage(diameter: CGFloat, color: UIColor) -> UIImage {
        let strokeWidth: CGFloat = 4
        let halfStrokeWidth = strokeWidth / 2
        let totalRect = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        let strokeRect = CGRect(x: halfStrokeWidth,
                                y: halfStrokeWidth,
                                width: diameter - strokeWidth,
                                height: diameter - strokeWidth)

        let renderer = UIGraphicsImageRenderer(size: totalRect.size)
        let image = renderer.image { context in
            context.cgContext.setStrokeColor(color.cgColor)
            context.cgContext.setLineWidth(strokeWidth)
            context.cgContext.strokeEllipse(in: strokeRect)
        }

        return image
    }

    static func trackImage(colored color: UIColor,
                           thumbWidth: CGFloat,
                           trackWidth: CGFloat,
                           value: CGFloat,
                           flipped: Bool) -> UIImage {

        let fraction = flipped ? 1 - value : value
        let adjustableWidth = (trackWidth - thumbWidth)
        let halfThumbWidth = thumbWidth / 2
        let fudgeFactor: CGFloat = 0

        var totalRect: CGRect

        var coloredRect: CGRect
        if flipped {
            totalRect = CGRect(x: 0, y: 0, width: trackWidth, height: trackWidth)
            coloredRect = CGRect(
                x: adjustableWidth * value + thumbWidth - fudgeFactor,
                y: 0,
                width: adjustableWidth * fraction + (halfThumbWidth - fudgeFactor),
                height: trackWidth)
        } else {
            totalRect = CGRect(x: 0, y: 0, width: adjustableWidth * fraction + halfThumbWidth, height: 2)
            coloredRect = CGRect(x: 0, y: 0, width: adjustableWidth * fraction, height: 2)
        }

        let renderer = UIGraphicsImageRenderer(size: totalRect.size)
        let image = renderer.image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.fill(coloredRect)
        }

        return image
    }

    @objc func updateTrackImages() {

        let trackWidth = CGRect(x: 0, y: 0, width: 1000, height: 1000).width
        let minimumImage = TransparentThumbSlider.trackImage(
            colored: .black,
            thumbWidth: thumbWidth,
            trackWidth: trackWidth,
            value: CGFloat(value),
            flipped: false)
        setMinimumTrackImage(minimumImage, for: .normal)

        let maximumImage = TransparentThumbSlider.trackImage(
            colored: .black,
            thumbWidth: thumbWidth,
            trackWidth: trackWidth,
            value: CGFloat(value),
            flipped: false)
        setMaximumTrackImage(maximumImage, for: .normal)
    }

    var previousBounds: CGRect = .zero

    override func layoutSubviews() {
        super.layoutSubviews()

        // Prevent layout loop
        if previousBounds != bounds {
            previousBounds = bounds
            updateTrackImages()
        }
    }
}
