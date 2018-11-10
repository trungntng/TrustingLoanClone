//
//  LoanInputModel.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/7/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import Foundation

enum LoanInputType {
    case phone, name, idNumber, province, income
}

class LoanInputModel: NSObject {
    let loanInputType: LoanInputType
    @objc dynamic var isInputValid: Bool = false
    
    init(loanInputType: LoanInputType, isInputValid: Bool) {
        self.loanInputType = loanInputType
        self.isInputValid = isInputValid
    }
}
