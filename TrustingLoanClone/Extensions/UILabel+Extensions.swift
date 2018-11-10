//
//  UILabel+Extension.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/8/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

extension UILabel {
    func setRequired(text: String) {
        let attributeString = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.font: self.font, NSAttributedString.Key.foregroundColor: UIColor.black])
        let requiredString = NSAttributedString(string: "*", attributes: [NSAttributedString.Key.font: self.font, NSAttributedString.Key.foregroundColor: UIColor.red])
        attributeString.append(requiredString)
        self.attributedText = attributeString
    }
}
