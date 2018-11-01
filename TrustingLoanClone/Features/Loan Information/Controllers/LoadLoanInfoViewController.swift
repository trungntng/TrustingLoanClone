//
//  LoadLoanInfoViewController.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 10/31/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

class LoadLoanInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        HUDView.showHUD()
        MockLoanInformation.getLoanInformation { (loanInfo) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                HUDView.hideHUD()
                self.performSegue(withIdentifier: "LoanInfoSegue", sender: loanInfo)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let navigationController = segue.destination as! UINavigationController
        let vc = navigationController.viewControllers.first as! LoanInfoViewController
        vc.loanInfo = sender as? LoanInfo
    }

}
