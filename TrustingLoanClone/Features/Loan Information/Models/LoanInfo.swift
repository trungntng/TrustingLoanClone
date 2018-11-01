//
//  LoanInfo.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 10/31/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import Foundation

class LoanInfo {
    let minAmount: Int
    let maxAmount: Int
    let minTenor: Int
    let maxTenor: Int
    let interestRate: Double
    let bankName: String
    let bankLogoUrl: String
    
    init(minAmount: Int, maxAmount: Int, minTenor: Int, maxTenor: Int, interestRate: Double, bankName: String, bankLogoUrl: String) {
        self.minAmount = minAmount
        self.maxAmount = maxAmount
        self.minTenor = minTenor
        self.maxTenor = maxTenor
        self.interestRate = interestRate
        self.bankName = bankName
        self.bankLogoUrl = bankLogoUrl
    }
    
    convenience init?(fromResponse response: [String: Any]) {
        guard let minAmount = response["min_amount"] as? Int,
        let maxAmount = response["max_amount"] as? Int,
        let minTenor = response["min_tenor"] as? Int,
        let maxTenor = response["max_tenor"] as? Int,
        let interestRate = response["interest_rate"] as? Double,
        let bank = response["bank"] as? [String: String],
        let bankName = bank["name"],
        let bankLogoUrl = bank["logo"]
            else { return nil }
        
        self.init(minAmount: minAmount, maxAmount: maxAmount, minTenor: minTenor, maxTenor: maxTenor, interestRate: interestRate, bankName: bankName, bankLogoUrl: bankLogoUrl)
    }
}

/*
 }
 "min_amount": 30000000,
 "max_amount": 100000000,
 "min_tenor": 6,
 "max_tenor": 18,
 "interest_rate": 19.99,
 "bank": {
 }
 "name": "Vietcombank",
 "logo": "https://www.vietcombank.com.vn/images/logo30.png"
 }
 */
