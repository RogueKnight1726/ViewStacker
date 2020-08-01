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
    
    
    
    
    var knobView = UIView()
    var innerDialView = UIView()
    var label = UILabel()
    var seperationView = UIView()
    var totalvalueLabel = UILabel()
    var progressValue: Float?{
        didSet{
//            if type == ProgressViewType.Percentage {
            let initialAnimation                   = CABasicAnimation(keyPath: "strokeEnd")
            initialAnimation.fromValue             = 0
            initialAnimation.toValue               = progressValue ?? 0
            initialAnimation.beginTime             = 0
            initialAnimation.duration              = 0.2
            initialAnimation.fillMode              = CAMediaTimingFillMode.both
            initialAnimation.isRemovedOnCompletion = false
            
            progressLayer.add(initialAnimation, forKey: "creditAmountValue")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.layer.sublayers?.contains(tracklayer) ?? false { return }
        createCircularPath()
        
        innerDialView.translatesAutoresizingMaskIntoConstraints = false
        [innerDialView.heightAnchor.constraint(equalToConstant: frame.size.width),
        innerDialView.widthAnchor.constraint(equalToConstant: frame.size.width),
        innerDialView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        innerDialView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        innerDialView.backgroundColor = .blue
        
        knobView.translatesAutoresizingMaskIntoConstraints = false
        [knobView.heightAnchor.constraint(equalToConstant: 20),
         knobView.widthAnchor.constraint(equalToConstant: 20),
         knobView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -frame.size.width),
         knobView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)].forEach({$0.isActive = true})
        self.bringSubviewToFront(innerDialView)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(innerDialView)
        innerDialView.addSubview(knobView)
        knobView.backgroundColor = .purple
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
        progressLayer.strokeStart = 0.0
        layer.addSublayer(progressLayer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progressValue = 0.5
        }
    }
    
}
