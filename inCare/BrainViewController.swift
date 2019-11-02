//
//  BrainViewController.swift
//  inCare
//
//  Created by Andrew Carvajal on 8/15/19.
//  Copyright © 2019 inCare. All rights reserved.
//

import UIKit

class BrainViewController: UIViewController {

    // MARK: - OUTLETS
    
    @IBOutlet var topTaskView: UIView!
    @IBOutlet var leftTaskView: UIView!
    @IBOutlet var rightTaskView: UIView!
    @IBOutlet var bottomTaskView: UIView!
    
    // MARK: - PROPERTIES
    
    var topTaskCircleImageView = UIImageView()
    var leftTaskCircleImageView = UIImageView()
    var rightTaskCircleImageView = UIImageView()
    var bottomTaskCircleImageView = UIImageView()
    
    let progressShape = CAShapeLayer()
    let backgroundShape = CAShapeLayer()
    var percent = 1.0

    // MARK: - LIFECYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(backgroundShape)
        view.layer.addSublayer(progressShape)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateIndicator(imageView: rightTaskCircleImageView, percent: percent, isAnimated: true)
    }
    
//    func setupImageViews() {
//        topTaskCircleImageView.tag = 0
//        leftTaskCircleImageView.tag = 1
//        rightTaskCircleImageView.tag = 2
//        bottomTaskCircleImageView.tag = 3
//    }
    
    func updateIndicator(imageView: UIView, percent: Double, isAnimated: Bool = false) {
        let shortestSide = min(imageView.frame.size.width, imageView.frame.size.height)
        let strokeWidth: CGFloat = 4
        let frame = CGRect(x: imageView.frame.minX, y: imageView.frame.minY, width: shortestSide - strokeWidth, height: shortestSide - strokeWidth)
        backgroundShape.frame = imageView.frame
        backgroundShape.path = UIBezierPath(ovalIn: backgroundShape.frame).cgPath
        backgroundShape.position = imageView.center
        backgroundShape.strokeColor = UIColor.clear.cgColor
        backgroundShape.lineWidth = strokeWidth
        backgroundShape.fillColor = UIColor.clear.cgColor
        progressShape.frame = frame
        progressShape.path = backgroundShape.path
        progressShape.position = backgroundShape.position
        progressShape.strokeColor = UIColor.black.cgColor
        progressShape.lineWidth = backgroundShape.lineWidth
        progressShape.fillColor = UIColor.clear.cgColor
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = progressShape.strokeEnd
        animation.toValue = percent/100.0
        animation.duration = 2.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        guard isAnimated else { return }
        progressShape.add(animation, forKey: nil)
    }
}
