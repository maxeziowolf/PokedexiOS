//
//  CirculesElementView.swift
//  PokemonMaster
//
//  Created by Maximiliano Ovando Ramírez on 10/08/23.
//

import UIKit

class CirculesElementView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let color = UIColor.white.withAlphaComponent(CGFloat(0.2))
        color.setFill()

        var position = CGRect(x: rect.minX, y: rect.minY, width: 10, height: 10)

        while (position.minX < rect.maxX) || (position.minY < rect.maxY) {

            if position.maxX < rect.maxX {
                let path = UIBezierPath(ovalIn: position)
                path.fill()
                position = position.offsetBy(dx: 20, dy: 0)
            } else {
                position = CGRect(x: rect.minX, y: position.maxY + 10, width: 10, height: 10)
            }

        }

    }

}
