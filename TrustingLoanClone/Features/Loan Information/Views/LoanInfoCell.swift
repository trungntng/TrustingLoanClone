//
//  LoanInfoCell.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/1/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

class LoanInfoCell: UITableViewCell {
    
    @IBOutlet weak var viewSubContent: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        viewSubContent.layer.borderWidth = 1
        viewSubContent.layer.borderColor = UIColor.blue.cgColor
    }

    func set(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
}
