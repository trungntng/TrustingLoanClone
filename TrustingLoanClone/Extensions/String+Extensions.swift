//
//  String+Extensions.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/8/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import Foundation

extension String {
    
    func isValidNationalID() -> Bool {
        return isValid(forRegex: "^(\\d{9}|\\d{12})$")
    }
    
    func isValidPhoneNumber() -> Bool {
        return isValid(forRegex: "^(0120|0121|0122|0123|0124|0125|0126|0127|0128|0129|0162|0163|0164|0165|0166|0167|0168|0169|0186|0188|0199|086|088|089|090|091|092|093|094|095|096|097|098|099)\\d{7}$")
    }
    
    func isValid(forRegex regex: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: regex)
        return regex.numberOfMatches(in: self, options: [], range: NSRange(location: 0, length: self.count)) > 0
    }
}
