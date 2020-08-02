//
//  CircularProgressView.swift
//  ViewStacker
//
//  Created by Next on 01/08/20.
//  Copyright © 2020 Next. All rights reserved.
//

import UIKit


class CircularProgressView: UIView{
    
    fileprivate var progressLayer = CAShapeLayer()
    fileprivate var tracklayer = CAShapeLayer()
    
    
    fileprivate var trackColor: CGColor!
    fileprivate var progressColor: CGColor!
    
    
    
    var maximumCreditValue: Float = 700000
    var creditLabel: UILabel!
    var creditValueLabel: UILabel!
    var innerDialView: BaseView!
    var currentValue: Float = 0
    let numberFormatter = NumberFormatter()
    weak var delegate: CircularProgressValueProtocol?
    var progressValue: Float?{
        didSet{
//            if type == ProgressViewType.Percentage {
            let initialAnimation                   = CABasicAnimation(keyPath: "strokeEnd")
            initialAnimation.fromValue             = currentValue
            initialAnimation.toValue               = progressValue ?? 0
            initialAnimation.beginTime             = 0
            initialAnimation.duration              = 0
            initialAnimation.fillMode              = CAMediaTimingFillMode.both
            initialAnimation.isRemovedOnCompletion = false
            currentValue = progressValue ?? 0
            progressLayer.add(initialAnimation, forKey: "creditAmountValue")
            let topLimit = min(maximumCreditValue, maximumCreditValue * (progressValue ?? 0))
            let decimalPlacesCorrectedvalue = Int(topLimit)
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSize = 3
            numberFormatter.secondaryGroupingSize = 2
            if let amountValue = numberFormatter.string(from: NSNumber(value: decimalPlacesCorrectedvalue)){
                creditValueLabel.text = "₹\(amountValue)"
                delegate?.currentValueOfCircularProgressView(value: "₹\(amountValue)")
            } else {
                creditValueLabel.text = "₹\(decimalPlacesCorrectedvalue)"
                delegate?.currentValueOfCircularProgressView(value: "₹\(decimalPlacesCorrectedvalue)")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.layer.sublayers?.contains(tracklayer) ?? false { return }
        createCircularPath()
        
        innerDialView.translatesAutoresizingMaskIntoConstraints = false
        [innerDialView.heightAnchor.constraint(equalToConstant: frame.size.width * 3 / 2),
        innerDialView.widthAnchor.constraint(equalToConstant: frame.size.width * 3 / 2),
        innerDialView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        innerDialView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        
        creditLabel.translatesAutoresizingMaskIntoConstraints = false
        [creditLabel.centerXAnchor.constraint(equalTo: innerDialView.centerXAnchor, constant: 0),
         creditLabel.bottomAnchor.constraint(equalTo: innerDialView.centerYAnchor, constant: -10)].forEach({$0.isActive = true})
        
        creditValueLabel.translatesAutoresizingMaskIntoConstraints = false
        [creditValueLabel.leftAnchor.constraint(equalTo: innerDialView.leftAnchor, constant: 10),
         creditValueLabel.rightAnchor.constraint(equalTo: innerDialView.rightAnchor, constant: -10),
         creditValueLabel.topAnchor.constraint(equalTo: innerDialView.centerYAnchor, constant: 10)].forEach({$0.isActive = true})
        
        self.bringSubviewToFront(innerDialView)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        innerDialView = BaseView.init(with: .white, circular: true, shadow: false, borderColor: UIColor(red: 1.00, green: 0.92, blue: 0.88, alpha: 1.00), borderThickness: 1)
        self.addSubview(innerDialView)
        creditLabel = UILabel()
        creditLabel.text = "credit amount"
        creditLabel.textColor = AppTheme.textColor
        creditLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        innerDialView.addSubview(creditLabel)
        
        creditValueLabel = UILabel()
        creditValueLabel.text = "1,00,00,000"
        creditValueLabel.textColor = .darkGray
        creditValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        creditValueLabel.textAlignment = .center
        innerDialView.addSubview(creditValueLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    convenience init(progress: Double, trackColor: UIColor, progressColor: UIColor){
        self.init()
        self.trackColor = trackColor.cgColor
        self.progressColor = progressColor.cgColor
    }
    
    

    
    
    fileprivate func createCircularPath() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                      radius: (frame.size.width), startAngle: CGFloat(-0.5 * Double.pi),
                                      endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        
        tracklayer.path = circlePath.cgPath
        tracklayer.fillColor = UIColor.clear.cgColor
        tracklayer.strokeColor = trackColor
        tracklayer.lineWidth = 12
        tracklayer.strokeStart = 0
        tracklayer.strokeEnd = 1.0
        layer.addSublayer(tracklayer)
        
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor
        progressLayer.lineWidth = 12
        progressLayer.strokeEnd = 0
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0.0
        layer.addSublayer(progressLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.progressValue = 0.1
        }
    }
    
}


protocol CircularProgressValueProtocol: AnyObject{
    func currentValueOfCircularProgressView(value: String)
}
