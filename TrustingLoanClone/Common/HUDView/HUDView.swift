//
//  HUDView.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/1/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

class HUDView: UIView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    static func loadNib() -> HUDView {
        return Bundle.main.loadNibNamed(String(describing: HUDView.self), owner: nil, options: nil)?.first as! HUDView
    }
    
    static let shared = HUDView.loadNib()
    
    static func showHUD(title: String = "Please wait...") {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window else {
            return
        }
        let hudView = HUDView.shared
        
        DispatchQueue.main.async {
            if hudView.isDescendant(of: window) {
                hudView.titleLabel.text = title
            } else {
                hudView.titleLabel.text = title
                hudView.activityIndicator.startAnimating()
                hudView.alpha = 0
                window.addSubview(hudView)
                hudView.frame = window.bounds
                UIView.animate(withDuration: Constants.animationDuration, animations: {
                    hudView.alpha = 1
                })
            }
        }
    }
    
    static func hideHUD() {
        let hudView = HUDView.shared
        
        DispatchQueue.main.async {
            if hudView.activityIndicator.isAnimating {
                UIView.animate(withDuration: Constants.animationDuration, animations: {
                    hudView.alpha = 0
                }, completion: { (_) in
                    hudView.activityIndicator.stopAnimating()
                    hudView.removeFromSuperview()
                })
            }
        }
    }
}
