//
//  LoanInfoViewController.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 10/31/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

class LoanInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var loanInfo: LoanInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: LoanInfoCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoanInfoCell.self))
    }
    

}


extension LoanInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoanInfoCell.self), for: indexPath) as! LoanInfoCell
        
        guard let loanInfo = loanInfo else {
            cell.set(title: "N/A", subTitle: "N/A")
            return cell
        }
        
        let currencyFormat = NumberFormatter()
        currencyFormat.numberStyle = .currency
        currencyFormat.locale = Locale(identifier: "vi_VN")
        
        switch indexPath.row {
        case 0:
            cell.set(title: "Minimum amount", subTitle: currencyFormat.string(from: loanInfo.minAmount as NSNumber)!)
        case 1:
            cell.set(title: "Maximum amount", subTitle: currencyFormat.string(from: loanInfo.maxAmount as NSNumber)!)
        case 2:
            cell.set(title: "Minimum tenor", subTitle: "\(loanInfo.minTenor) months")
        case 3:
            cell.set(title: "Maximum tenor", subTitle: "\(loanInfo.maxTenor) months")
        case 4:
            cell.set(title: "Interest (per year)", subTitle: "\(loanInfo.interestRate) %")
        default:
            cell.set(title: "N/A", subTitle: "N/A")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var title: String!
        var message: String!
        
        switch indexPath.row {
        case 0:
            title = "Minimum amount"
            message = "The minimum amount of loan you can get"
        case 1:
            title = "Maximum amount"
            message = "The maximum amount of loan you can get"
        case 2:
            title = "Minimum tenor"
            message = "The minimum tenor of your loan that would be calculated per month"
        case 3:
            title = "Maximum tenor"
            message = "The maximum tenor of your loan that would be calculated per month"
        case 4:
            title = "Interest"
            message = "The interest rate of your loan that would be calculated per year"
        default:
            return
        }
        
        DispatchQueue.main.async {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(ac, animated: true, completion: nil)
        }
    }
}
