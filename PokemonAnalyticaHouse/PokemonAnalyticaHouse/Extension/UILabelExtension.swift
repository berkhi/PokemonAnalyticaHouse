//
//  UILabelExtension.swift
//  PokemonAnalyticaHouse
//
//  Created by BerkH on 28.03.2023.
//

import Foundation
import UIKit

extension UILabel {
    func customLabelFont(label: UILabel,text: String, start: Int, finish: Int, fontType: String, size: CGFloat) {
        
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: start, length: finish))
        attributedString.addAttribute(.font, value: UIFont(name: fontType, size: size)!, range: NSRange(location: start, length: finish))
        
        label.attributedText = attributedString
    }
}
