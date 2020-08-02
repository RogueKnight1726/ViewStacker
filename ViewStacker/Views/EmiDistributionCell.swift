//
//  EmiDistributionCell.swift
//  ViewStacker
//
//  Created by Next on 02/08/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit

class EmiDistributionCell: UICollectionViewCell{
    
    var installmentLabel: UILabel!
    var durationLabel: UILabel!
    var baseView: BaseView!
    var calculationsButton: UIButton!
    var selectedImageView: UIImageView!
    var model: EMIModel?{
        didSet{
            installmentLabel.text = "₹\(model?.amountToBePaid ?? 0)"
            durationLabel.text = "\(model?.duration ?? 0) months"
            selectedImageView.alpha = (model?.selected ?? false) ? 1 : 0
        }
    }
    var backColor: UIColor!{
        didSet{
            baseView.setColorToBaseView(color: backColor)
        }
    }
    
    override var isSelected: Bool{
        didSet{
            selectedImageView.alpha = isSelected ? 1 : 0
            model?.selected = isSelected
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        baseView = BaseView.init(with: .white, circular: false, shadow: false, borderColor: nil, borderThickness: nil)
        self.addSubview(baseView)
        installmentLabel = UILabel()
        self.addSubview(installmentLabel)
        durationLabel = UILabel()
        self.addSubview(durationLabel)
        selectedImageView = UIImageView()
        self.addSubview(selectedImageView)
        selectedImageView.image = UIImage.init(named: "selectedIcon")
        selectedImageView.alpha = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}



extension EmiDistributionCell{
    
    
    
    func initConstraints(){
        
        
        baseView.translatesAutoresizingMaskIntoConstraints = false
        [baseView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
         baseView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
         baseView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
         baseView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)].forEach({$0.isActive = true})
        
        
        
        installmentLabel.translatesAutoresizingMaskIntoConstraints = false
        [installmentLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
         installmentLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
         installmentLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8)].forEach({$0.isActive  = true})
        installmentLabel.numberOfLines = 2
        installmentLabel.lineBreakMode = .byTruncatingTail
        installmentLabel.textColor = .white
        installmentLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        [durationLabel.leftAnchor.constraint(equalTo: installmentLabel.leftAnchor, constant: 0),
         durationLabel.topAnchor.constraint(equalTo: installmentLabel.bottomAnchor, constant: 4),
         durationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)].forEach({$0.isActive = true})
        durationLabel.numberOfLines = 2
        durationLabel.lineBreakMode = .byTruncatingTail
        durationLabel.font = UIFont.systemFont(ofSize: 13, weight: .light)
        durationLabel.textColor = .white
        
        calculationsButton = UIButton()
        calculationsButton.setTitle("see calculations", for: .normal)
        calculationsButton.setTitleColor(.white, for: .normal)
        calculationsButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .ultraLight)
        self.addSubview(calculationsButton)
        calculationsButton.translatesAutoresizingMaskIntoConstraints = false
        [calculationsButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
         calculationsButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)].forEach({$0.isActive = true})
    
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        [selectedImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
         selectedImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
         selectedImageView.heightAnchor.constraint(equalToConstant: 20),
         selectedImageView.widthAnchor.constraint(equalToConstant: 20)].forEach({$0.isActive = true})
    }
}
