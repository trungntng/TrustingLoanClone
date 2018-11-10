//
//  LoanInputCell.swift
//  TrustingLoanClone
//
//  Created by Trung Trinh on 11/7/18.
//  Copyright © 2018 Trung Trinh. All rights reserved.
//

import UIKit

class LoanInputCell: UITableViewCell {

    @IBOutlet weak var viewSubContent: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    private let smallTitleFont = UIFont.systemFont(ofSize: 12)
    private let normalTitleFont = UIFont.systemFont(ofSize: 16)
    private var provinces: [String]!
    private lazy var incomes = [
        "Less than 3.000.000",
        "3.000.000 to 10.000.000",
        "Greater than 10.000.000"
    ]
    private var loanInputModel: LoanInputModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        viewSubContent.layer.borderWidth = 1
        viewSubContent.layer.borderColor = UIColor.blue.cgColor
        
        textField.delegate = self
    }

    func set(loanInputModel: LoanInputModel) {
        self.loanInputModel = loanInputModel
        switch loanInputModel.loanInputType {
        case .phone:
            titleLabel.setRequired(text: "Phone number")
            textField.keyboardType = .phonePad
        case .name:
            titleLabel.setRequired(text: "Full name")
            textField.autocapitalizationType = .words
        case .idNumber:
            titleLabel.text = "National ID number"
            textField.keyboardType = .numberPad
        case .province:
            titleLabel.setRequired(text: "Province")
        case .income:
            titleLabel.setRequired(text: "Monthly income")
        }
    }
    
    func startEntering() {
        switch loanInputModel.loanInputType {
        case .province:
            HUDView.showHUD()
            MockLoanInformation.getProvinces { (provinces) in
                self.provinces = provinces
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                    HUDView.hideHUD()
                    let picker = UIPickerView()
                    picker.delegate = self
                    picker.dataSource = self
                    self.textField.inputView = picker
                    self.textField.becomeFirstResponder()
                })
            }
        case .income:
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            textField.inputView = picker
            textField.becomeFirstResponder()
        default:
            textField.becomeFirstResponder()
        }
    }
    
    func show(errorText: String?) {
        guard let error = errorText else {
            switch loanInputModel.loanInputType {
            case .phone:
                titleLabel.setRequired(text: "Phone number")
                textField.keyboardType = .phonePad
            case .name:
                titleLabel.setRequired(text: "Full name")
                textField.autocapitalizationType = .words
            case .idNumber:
                titleLabel.text = "National ID number"
                titleLabel.textColor = .black
                textField.keyboardType = .numberPad
            case .province:
                titleLabel.setRequired(text: "Province")
            case .income:
                titleLabel.setRequired(text: "Monthly income")
            }
            return
        }
        titleLabel.text = error
        titleLabel.textColor = .red
    }
    
}

extension LoanInputCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text as NSString? else { return true }
        let updatedText = text.replacingCharacters(in: range, with: string)
        
        switch loanInputModel.loanInputType {
        case .phone:
            show(errorText: updatedText.isValidPhoneNumber() ? nil : "Phone number is incorrect!")
            loanInputModel.isInputValid = updatedText.isValidPhoneNumber()
        case .name:
            show(errorText: updatedText.isEmpty ? "Full name cannot be empty!" : nil)
            loanInputModel.isInputValid = !updatedText.isEmpty
        case .idNumber:
            show(errorText: updatedText.isValidNationalID() ? nil : "National ID number must be 9 or 12 digits!")
            loanInputModel.isInputValid = updatedText.isValidNationalID() || updatedText.isEmpty
        default:
            break
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isHidden = textField.text == ""
        titleLabel.font = textField.text == "" ? normalTitleFont : smallTitleFont
        if textField.text == "" {
            show(errorText: nil)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.isHidden = false
        titleLabel.font = smallTitleFont
    }
}

extension LoanInputCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch loanInputModel.loanInputType {
        case .province:
            return provinces.count
        case .income:
            return incomes.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch loanInputModel.loanInputType {
        case .province:
            return provinces[row]
        case .income:
            return incomes[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch loanInputModel.loanInputType {
        case .province:
            textField.text = provinces[row]
            loanInputModel.isInputValid = true
        case .income:
            textField.text = incomes[row]
            loanInputModel.isInputValid = true
        default:
            break
        }
    }
    
}
