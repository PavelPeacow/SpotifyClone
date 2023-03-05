//
//  MusicVisualizerView.swift
//  SpotifyClone
//
//  Created by Павел Кай on 05.03.2023.
//

import UIKit

class MusicVisualizerView: UIView {
    
    private var barLayers: [CALayer] = []
    private let barCount = 3
    private let barWidth: CGFloat = 5.0
    private let barSpacing: CGFloat = 1.0
    
    private lazy var displayLink = CADisplayLink(target: self, selector: #selector(updateChart(_:)))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        for i in 0..<barCount {
            let barLayer = CALayer()
            barLayer.frame = CGRect(x: CGFloat(i) * (barWidth + barSpacing), y: 0, width: barWidth, height: 0)
            barLayer.backgroundColor = UIColor.green.cgColor
            layer.addSublayer(barLayer)
            barLayers.append(barLayer)
        }
        
        
        displayLink.add(to: .current, forMode: .common)
    }
    
    func pausePlaying() {
        displayLink.invalidate()
    }
    
    @objc private func updateChart(_ displayLink: CADisplayLink) {
        let amplitudes: [CGFloat] = (0..<barCount).map { _ in
            CGFloat.random(in: 0.1...1.0)
        }
        
        for i in 0..<barCount {
            let barLayer = barLayers[i]
            let barHeight = amplitudes[i] * frame.height
            barLayer.frame.size.height = barHeight
            barLayer.frame.origin.y = frame.height - barHeight - 3
        }
    }
}
