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

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.9546431899, blue: 0.8718495965, alpha: 1)
    }
    
    override func loadView() {
        super.loadView()
        addAllSubviews()
        constrainTitleLabel()
        setupBillTotalStackView()
    }
    
    //MARK: - Helper Methods
    func addAllSubviews() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(billTotalLabel)
        self.view.addSubview(billTotalTextField)
        self.view.addSubview(billTotalStackView)
    }
    
    func constrainTitleLabel() {
        titleLabel.anchor(top: self.safeArea.topAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 30, paddingBottom: 0, paddingLeading: 8, paddingTrailing: -8)
    }
    
    func setupBillTotalStackView() {
        billTotalStackView.addArrangedSubview(billTotalLabel)
        billTotalStackView.addArrangedSubview(billTotalTextField)
        billTotalStackView.anchor(top: titleLabel.bottomAnchor, bottom: nil, leading: self.safeArea.leadingAnchor, trailing: self.safeArea.trailingAnchor, paddingTop: 50, paddingBottom: 0, paddingLeading: 40, paddingTrailing: -75, width: nil, height: 30)
    }
    
    //MARK: - Views
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Tip Calculator"
        label.textColor = #colorLiteral(red: 0.7302629352, green: 0.04440311342, blue: 0.1602434814, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.adjustsFontSizeToFitWidth = true

        return label
    }()
    
    let billTotalLabel: UILabel = {
        let label = UILabel()
        label.text = "Bill Total:"
        label.textColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
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

} //End of class
