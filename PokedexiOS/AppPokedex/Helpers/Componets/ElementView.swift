//
//  ElementView.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 10/08/23.
//

import UIKit
import SwiftUI

class ElementView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        let radius: CGFloat = 15

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: (rect.maxX * 8/10), y: rect.minY))
        path.addLine(to: CGPoint(x: (rect.maxX * 9/10), y: (rect.maxY * 8/10) - radius))
        path.addArc(withCenter: CGPoint(x: ((rect.maxX * 9/10) - radius), y: ((rect.maxY * 8/10) - radius)), radius: radius, startAngle: 0, endAngle: .pi/2, clockwise: true)
        path.addLine(to: CGPoint(x: rect.minX, y: (rect.maxY * 9.5/10)))

        let color = UIColor.white.withAlphaComponent(CGFloat(0.2))
        color.setFill()
        path.fill()

    }
}
