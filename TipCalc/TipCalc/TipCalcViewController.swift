//
//  TipCalcViewController.swift
//  TipCalc
//
//  Created by Bryan Workman on 1/20/21.
//

import UIKit

class TipCalcViewController: UIViewController {
    
    //MARK: - Properties
    var safeArea: UILayoutGuide {
        return self.view.safeAreaLayoutGuide
    }
    var buttons: [UIButton] {
        return [tenPercentButton, fifteenPercentButton, eighteenPercentButton, twentyPercentButton, customTipButton, roundUpButton, roundDownButton]
    }
    var tipButtons: [UIButton] {
        return [tenPercentButton, fifteenPercentButton, eighteenPercentButton, twentyPercentButton, customTipButton]
    }
    var roundButtons: [UIButton] {
        return [roundUpButton, roundDownButton]
    }
    var tipTotal: Double = 0.00
    var finalTotal: Double = 0.00

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9546431899, blue: 0.8718495965, alpha: 1)
        activateButtons()
        tipTotalStackView.isHidden = true
        roundStackView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func loadView() {
        super.loadView()
        addAllSubviews()
        constrainTitleLabel()
        setupBillTotalStackView()
        setupTipPercentStackView()
        setupCustomTipStackView()
        setupTipTotalStackView()
        setupRoundStackView()
    }
    
    //MARK: - Helper Methods
    func activateButtons() {
        buttons.forEach { $0.addTarget(self, action: #selector(selectButton(sender:)), for: .touchUpInside) }
    }
    
    @objc func selectButton(sender: UIButton) {
        switch sender {
        case tenPercentButton:
            highlightButton(button: sender)
            customTipTextField.text = ""
            calculate(tipPercent: 0.10)
        case fifteenPercentButton:
            highlightButton(button: sender)
            customTipTextField.text = ""
            calculate(tipPercent: 0.15)
        case eighteenPercentButton:
            highlightButton(button: sender)
            customTipTextField.text = ""
            calculate(tipPercent: 0.18)
        case twentyPercentButton:
            highlightButton(button: sender)
            customTipTextField.text = ""
            calculate(tipPercent: 0.20)
        case customTipButton:
            customTipTextField.resignFirstResponder()
            guard let customTipText = customTipTextField.text, !customTipText.isEmpty else {return}
            highlightButton(button: sender)
            let customTip = (Double(customTipText) ?? 0.00) / 100
            calculate(tipPercent: customTip)
        case roundUpButton:
            highlightRoundButton(button: sender)
            roundUp()
        case roundDownButton:
            highlightRoundButton(button: sender)
            roundDown()
        default:
            print("button")
        }
    }
    
    func calculate(tipPercent: Double) {
        billTotalTextField.resignFirstResponder()
        guard let billTotalText = billTotalTextField.text, !billTotalText.isEmpty else {return}
        let billTotal = Double(billTotalText) ?? 0.00
        tipTotal = billTotal * tipPercent
        finalTotal = billTotal + tipTotal
        tipTotalStackView.isHidden = false
        tipLabel.text = "Tip:  $" + String(format: "%.2f", tipTotal)
        totalLabel.text = "Total:  $" + String(format: "%.2f", finalTotal)
        roundStackView.isHidden = false
    }
    
    func highlightButton(button: UIButton) {
        guard let billTotalText = billTotalTextField.text, !billTotalText.isEmpty else {return}
        clearRoundButtons()
        tipButtons.forEach( { $0.backgroundColor = .buttonBlue } )
        button.backgroundColor = .cyan
    }
    
    func highlightRoundButton(button: UIButton) {
        roundButtons.forEach( { $0.backgroundColor = .buttonBlue } )
        button.backgroundColor = .cyan
    }
    
    func clearRoundButtons() {
        roundButtons.forEach( { $0.backgroundColor = .buttonBlue } )
    }
    
    func roundUp() {
        let roundTotal = finalTotal.rounded(.up)
        print(finalTotal)
        print(roundTotal)
        let difference = roundTotal - finalTotal
        print(difference)
        let roundTip = tipTotal + difference
        tipLabel.text = "Tip:  $" + String(format: "%.2f", roundTip)
        totalLabel.text = "Total:  $" + String(format: "%.2f", roundTotal)
    }
    
    func roundDown() {
        let roundTotal = finalTotal.rounded(.down)
        print(finalTotal)
        print(roundTotal)
        let difference = finalTotal - roundTotal
        print(difference)
        let roundTip = tipTotal - difference
        tipLabel.text = "Tip:  $" + String(format: "%.2f", roundTip)
        totalLabel.text = "Total:  $" + String(format: "%.2f", roundTotal)
    }
    
    func addAllSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(billTotalLabel)
        self.view.addSubview(billTotalTextField)
        self.view.addSubview(billTotalStackView)
        self.view.addSubview(tenPercentButton)
        self.view.addSubview(fifteenPercentButton)
        self.view.addSubview(eighteenPercentButton)
        self.view.addSubview(twentyPercentButton)
        self.view.addSubview(tipPercentStackView)
        self.view.addSubview(customTipLabel)
        self.view.addSubview(customTipTextField)
        self.view.addSubview(customTipButton)
        self.view.addSubview(customTipStackView)
        self.view.addSubview(tipLabel)
        self.view.addSubview(totalLabel)
        self.view.addSubview(tipTotalStackView)
        self.view.addSubview(roundUpButton)
        self.view.addSubview(roundDownButton)
        self.view.addSubview(roundStackView)
    }
    
    func constrainTitleLabel() {
        titleLabel.anchor(top: self.safeArea.topAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeading: 8, paddingTrailing: -8)
    }
    
    func setupBillTotalStackView() {
        billTotalStackView.addArrangedSubview(billTotalLabel)
        billTotalStackView.addArrangedSubview(billTotalTextField)
        billTotalStackView.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 50, paddingBottom: 0, paddingLeading: 40, paddingTrailing: -75, width: nil, height: 30)
    }
    
    func setupTipPercentStackView() {
        tipPercentStackView.addArrangedSubview(tenPercentButton)
        tipPercentStackView.addArrangedSubview(fifteenPercentButton)
        tipPercentStackView.addArrangedSubview(eighteenPercentButton)
        tipPercentStackView.addArrangedSubview(twentyPercentButton)
        tipPercentStackView.anchor(top: billTotalStackView.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeading: 30, paddingTrailing: -30, width: nil, height: 30)
    }
    
    func setupCustomTipStackView() {
        customTipStackView.addArrangedSubview(customTipLabel)
        customTipStackView.addArrangedSubview(customTipTextField)
        customTipStackView.addArrangedSubview(customTipButton)
        customTipStackView.anchor(top: tipPercentStackView.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 45, paddingBottom: 0, paddingLeading: 50, paddingTrailing: -50, width: nil, height: 30)
    }
    
    func setupTipTotalStackView() {
        tipTotalStackView.addArrangedSubview(tipLabel)
        tipTotalStackView.addArrangedSubview(totalLabel)
        tipTotalStackView.anchor(top: customTipStackView.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 100, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: nil, height: nil)
    }
    
    func setupRoundStackView() {
        roundStackView.addArrangedSubview(roundUpButton)
        roundStackView.addArrangedSubview(roundDownButton)
        roundStackView.anchor(top: tipTotalStackView.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 60, paddingBottom: 0, paddingLeading: 30, paddingTrailing: -30, width: nil, height: 30)
    }
    
    //MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tip Calculator"
        label.textColor = .brickRed
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    let billTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Bill Total:"
        label.textColor = .labelBlue
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 23)
        
        return label
    }()
    
    let billTotalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "$0.00"
        textField.backgroundColor = .white
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        
        return textField
    }()
    
    let billTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        
        return stackView
    }()
    
    let tenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("10%", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()
        
        return button
    }()
    
    let fifteenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("15%", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()
        
        return button
    }()
    
    let eighteenPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("18%", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()

        return button
    }()
    
    let twentyPercentButton: UIButton = {
        let button = UIButton()
        button.setTitle("20%", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()
        
        return button
    }()
    
    let tipPercentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        
        return stackView
    }()
    
    let customTipLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom Tip:"
        label.textColor = .labelBlue
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    let customTipTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0%"
        textField.backgroundColor = .white
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        
        return textField
    }()
    
    let customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()
        
        return button
    }()
    
    let customTipStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    let tipLabel: UILabel = {
        let label = UILabel()
        label.text = "Tip:  $0.00"
        label.textAlignment = .center
        label.textColor = .labelBlue
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 24)
        
        return label
    }()
    
    let totalLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:  $0.00"
        label.textAlignment = .center
        label.textColor = .labelBlue
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 24)
        
        return label
    }()
    
    let tipTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    let roundUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Round Up", for: .normal)
        button.setTitleColor(.brickRed, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()
        
        return button
    }()
    
    let roundDownButton: UIButton = {
        let button = UIButton()
        button.setTitle("Round Down", for: .normal)
        button.setTitleColor(.brickRed, for: .normal)
        button.backgroundColor = .buttonBlue
        button.addCornerRadius()
        
        return button
    }()
    
    let roundStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 30
        
        return stackView
    }()

} //End of class
