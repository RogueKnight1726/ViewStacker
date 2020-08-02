//
//  ThirdView.swift
//  ViewStacker
//
//  Created by Next on 31/07/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit
import StacksManager

class BankDetailsSelectionView: BaseView{
    
    weak var navigationDelegate: StackNavigationProtocol?
    
    public var currentState: ViewState!{
        didSet{
            headingLabel.alpha = 0
            subTitleLabel.alpha = 0
            dismissedHeadinglabel.alpha = 0
            switch currentState {
            case .Dismissed:
                dismissedHeadinglabel.alpha = 1
                break
            case .Visible:
                headingLabel.alpha = 1
                subTitleLabel.alpha = 1
                break
            case .FullScreen:
                break
            default:
                break
            }
            
        }
    }
    
    
    
    //App specific properties
    var headingLabel: UILabel!
    var subTitleLabel: UILabel!
    var dismissedHeadinglabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        dismissedHeadinglabel = UILabel()
        dismissedHeadinglabel.textColor = .white
        dismissedHeadinglabel.text = "Select your bank account"
        dismissedHeadinglabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        self.addSubview(dismissedHeadinglabel)
        dismissedHeadinglabel.translatesAutoresizingMaskIntoConstraints = false
        [dismissedHeadinglabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
         dismissedHeadinglabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        
        headingLabel = UILabel()
        self.addSubview(headingLabel)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        [headingLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 20),
         headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)].forEach({$0.isActive = true})
        headingLabel.text = "where should we send the money?"
        headingLabel.textColor = AppTheme.emiOptionsViewLabelColor
        headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headingLabel.alpha = 0
        
        headingLabel = UILabel()
        self.addSubview(headingLabel)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        [headingLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30)].forEach({$0.isActive = true})
        headingLabel.text = "where should we send the money?"
        headingLabel.textColor = AppTheme.emiOptionsViewLabelColor
        headingLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headingLabel.alpha = 0
        
        
        
        subTitleLabel = UILabel()
        self.addSubview(subTitleLabel)
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        [subTitleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         subTitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
         subTitleLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 14)].forEach({$0.isActive = true})
        subTitleLabel.text = "amount will be credited to this bank account.\n EMI will also be debited from this bank account."
        subTitleLabel.textColor = AppTheme.emiOptionsViewLabelColor
        subTitleLabel.numberOfLines = 3
        subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        subTitleLabel.alpha = 0
        
        
        let bankAccountThumbnail = BaseImageView.init(with: .white, circular: false, shadow: false, borderColor: nil, borderThickness: nil)
        self.addSubview(bankAccountThumbnail)
        bankAccountThumbnail.translatesAutoresizingMaskIntoConstraints = false
        [bankAccountThumbnail.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         bankAccountThumbnail.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30),
         bankAccountThumbnail.heightAnchor.constraint(equalToConstant: 60),
         bankAccountThumbnail.widthAnchor.constraint(equalToConstant: 60)].forEach({$0.isActive = true})
        bankAccountThumbnail.image = UIImage.init(named: "crypto")
        
        let walletHeading = UILabel()
        self.addSubview(walletHeading)
        walletHeading.translatesAutoresizingMaskIntoConstraints = false
        [walletHeading.leftAnchor.constraint(equalTo: bankAccountThumbnail.rightAnchor, constant: 16),
         walletHeading.bottomAnchor.constraint(equalTo: bankAccountThumbnail.centerYAnchor, constant: 0)].forEach({$0.isActive = true})
        walletHeading.text = "My Crypto Wallet"
        walletHeading.textColor = .white
        walletHeading.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        let walletIdLabel = UILabel()
        self.addSubview(walletIdLabel)
        walletIdLabel.translatesAutoresizingMaskIntoConstraints = false
        [walletIdLabel.leftAnchor.constraint(equalTo: bankAccountThumbnail.rightAnchor, constant: 14),
         walletIdLabel.topAnchor.constraint(equalTo: bankAccountThumbnail.centerYAnchor, constant: 4)].forEach({$0.isActive = true})
        walletIdLabel.text = "32xxxxxx-...-xxxxxxxxxx44"
        walletIdLabel.textColor = .white
        walletIdLabel.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        
        let selectionBaseView = BaseView.init(with: UIColor(red: 0.22, green: 0.25, blue: 0.29, alpha: 1.00), circular: true, shadow: false, borderColor: nil, borderThickness: nil)
        self.addSubview(selectionBaseView)
        selectionBaseView.translatesAutoresizingMaskIntoConstraints = false
        [selectionBaseView.heightAnchor.constraint(equalToConstant: 50),
         selectionBaseView.widthAnchor.constraint(equalToConstant: 50),
         selectionBaseView.centerYAnchor.constraint(equalTo: bankAccountThumbnail.centerYAnchor, constant: 0),
         selectionBaseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)].forEach({$0.isActive = true})
        
        let addNewBaseView = BaseView.init(with: UIColor(red: 0.09, green: 0.13, blue: 0.17, alpha: 1.00), circular: false, shadow: false, borderColor: AppTheme.baseViewButtonBorderColor, borderThickness: 3)
        self.addSubview(addNewBaseView)
        addNewBaseView.translatesAutoresizingMaskIntoConstraints = false
        [addNewBaseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
         addNewBaseView.topAnchor.constraint(equalTo: bankAccountThumbnail.bottomAnchor, constant: 20)].forEach({$0.isActive = true})
        
        let addDetailsLabel = UILabel()
        self.addSubview(addDetailsLabel)
        addDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        [addDetailsLabel.leftAnchor.constraint(equalTo: addNewBaseView.leftAnchor, constant: 20),
         addDetailsLabel.rightAnchor.constraint(equalTo: addNewBaseView.rightAnchor, constant: -20),
         addDetailsLabel.topAnchor.constraint(equalTo: addNewBaseView.topAnchor, constant: 10),
         addDetailsLabel.bottomAnchor.constraint(equalTo: addNewBaseView.bottomAnchor, constant: -10)].forEach({$0.isActive = true})
        addDetailsLabel.text = "Change account"
        addDetailsLabel.textColor = AppTheme.baseViewButtonBorderColor
        addDetailsLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    
}



extension BankDetailsSelectionView: StackViewDataSource{
    func recieveIncomingData(value: Any?) {
    }
    
    func sendDataToNextView() -> Any? {
        return nil
    }
    
    
    var state: ViewState {
        get {
            return currentState
        }
        set {
            self.currentState = newValue
        }
    }
    
    func heightOfHeaderView() -> CGFloat {
        return 50
    }
    
    
    
}
