//
//  LoanCompletedViewController.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/9/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit
import SafariServices

class LoanCompletedViewController: UIViewController {
    
    let supportURL = "http://www.vietcombank.com.vn/EBanking/PhoneBanking"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func completeBtnPressed(_ sender: Any) {
        let webView = SFSafariViewController(url: URL(string: supportURL)!)
        webView.dismissButtonStyle = .close
        webView.preferredControlTintColor = UIColor.blue
        
        let navigationController = UINavigationController(rootViewController: webView)
        navigationController.isNavigationBarHidden = true
        
        present(navigationController, animated: true, completion: nil)
    }
    
    
}
