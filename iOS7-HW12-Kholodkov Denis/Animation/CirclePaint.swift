//
//  CirclePaint.swift
//  iOS7-HW12-Kholodkov Denis
//
//  Created by Денис Холодков on 20.08.2022.
//

import UIKit

class CirclePaint: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var circleLayer = CAShapeLayer() // слой круга
    var progressLayer = CAShapeLayer() // слой прогресса (идет таймер)
    private var startPosition = CGFloat(-Double.pi / 2)
    private var endPosition = CGFloat(3 * Double.pi / 2)

    func createCircularPath(toneColor: CGColor) {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0,
                                                           y: frame.size.height / 2.0),
                                        radius: ViewController.progressBarWidth/2,
                                        startAngle: startPosition,
                                        endAngle: endPosition,
                                        clockwise: true)
        // путь для круга
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = 6.0
        circleLayer.strokeEnd = 1
        circleLayer.strokeColor = toneColor
        layer.addSublayer(circleLayer)

        // путь прохождения круга
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .butt
        progressLayer.lineWidth = 7.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = Colors.mainViewBackgroundColor.cgColor
        layer.addSublayer(progressLayer)
    }

    func progressAnimation(duration: TimeInterval) {

        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        //настройка времени
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnimation")
    }
}
