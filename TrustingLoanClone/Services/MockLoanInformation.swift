//
//  MockLoanInformation.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 10/31/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import Foundation

class MockLoanInformation {
    static func getLoanInformation(completed: @escaping (LoanInfo) -> Void) {
        let data: [String: Any] = [
            "min_amount": 30000000,
            "max_amount": 100000000,
            "min_tenor": 6,
            "max_tenor": 18,
            "interest_rate": 19.99,
            "bank": [
                "name": "Vietcombank",
                "logo": "https://www.vietcombank.com.vn/images/logo30.png"
            ]
        ]
        let loanInfo = LoanInfo(fromResponse: data)!
        
        completed(loanInfo)
    }
}

/*
 {
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

/*
 {
 "total": 10,
 "provinces_list": [
 "An Giang",
 "Bắc Giang",
 "Bắc Kạn",
 "Bạc Liêu",
 "Bắc Ninh",
 "Bà Rịa - Vũng Tàu",
 "Bến Tre",
 "Bình Định",
 "Bình Dương",
 "Bình Phước"
 ]
 }
 */
