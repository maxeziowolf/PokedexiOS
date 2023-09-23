//
//  RoundedView.swift
//  PokedexiOS
//
//  Created by Maximiliano Ovando Ramírez on 22/09/23.
//

import UIKit

class RoundedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIRectFill(rect)

        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20)
        UIColor.white.setFill()
        path.fill()

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
