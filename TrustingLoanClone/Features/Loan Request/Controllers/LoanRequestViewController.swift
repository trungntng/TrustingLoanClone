//
//  LoanRequestViewController.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/7/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

class LoanRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    private let loanInputs: [LoanInputModel] = [
        LoanInputModel(loanInputType: .phone, isInputValid: false),
        LoanInputModel(loanInputType: .name, isInputValid: false),
        LoanInputModel(loanInputType: .idNumber, isInputValid: true),
        LoanInputModel(loanInputType: .province, isInputValid: false),
        LoanInputModel(loanInputType: .income, isInputValid: false)
    ]
    
    private var observations = [NSKeyValueObservation]()
    
    private func setupObservations() {
        removeObervations()
        for loanInput in loanInputs {
            observations.append(loanInput.observe(\.isInputValid, changeHandler: { (_, _) in
                let falseInputs = self.loanInputs.filter({ (loanInput) -> Bool in
                    return loanInput.isInputValid == false
                })
                self.submitButton.isEnabled = falseInputs.count == 0
                self.submitButton.alpha = falseInputs.count == 0 ? 1 : 0.5
            }))
        }
    }
    
    private func removeObervations() {
        for observer in observations {
            observer.removeObserver(observer, forKeyPath: "isInputValid")
        }
        observations.removeAll()
    }
    
    deinit {
        removeObervations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        submitButton.alpha = 0.5
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: LoanInputCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoanInputCell.self))
        
        setupObservations()
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        HUDView.showHUD(title: "Processing request")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            HUDView.hideHUD()
            self.performSegue(withIdentifier: "LoanCompletedSegue", sender: nil)
        }
    }
    
}

extension LoanRequestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loanInputs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoanInputCell.self), for: indexPath) as! LoanInputCell
        cell.set(loanInputModel: loanInputs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! LoanInputCell
        cell.startEntering()
    }
    
}
