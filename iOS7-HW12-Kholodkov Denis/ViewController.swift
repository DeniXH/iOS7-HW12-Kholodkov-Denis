//
//  ViewController.swift
//  iOS7-HW12-Kholodkov Denis
//
//  Created by Денис Холодков on 20.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private var isWorkTime = false
    private var isStarted = false
    var timer = Timer()
    var time = Int()

    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()

//    private lazy var imageCircle: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "")
//        return imageView
//    }()

    private lazy var buttonPlay: UIButton = {
        let buttonPlay = UIButton()
        let image = UIImage(systemName: "play")
        buttonPlay.setImage(image, for: .normal)
        buttonPlay.frame.size = CGSize(width: 40, height: 40)
        buttonPlay.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.thin), forImageIn: .normal)
        buttonPlay.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return buttonPlay
    }()

//MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setConstraints()
    }

    @objc private func playButtonAction() {
        if !isStarted {
            labelTimer.text = timeFormat()
            isStarted = true
            startTimer()
            buttonPlay.setImage(UIImage(systemName: "pause"), for: .normal)
// показатель движения
        } else {
            timer.invalidate()
            
        }

    }

    func timeFormat() -> String {
        let min = time / 60 % 60
        let sec = time % 60
        return String(format: "%02i:%02i", min, sec)
    }

    //MARK: Timer
    func startTimer() {
    }
    func updateTimer() {
    }


    private func setupHierarchy() {
        view.addSubview(labelTimer)
        view.addSubview(buttonPlay)
    }

    private func setConstraints() {
        labelTimer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
            make.centerX.equalTo(view)
        }

        buttonPlay.snp.makeConstraints { make in
            make.top.equalTo(labelTimer.snp.bottom).offset(40)
            make.centerX.equalTo(view)
//            make.height.equalTo(300)
//            make.width.equalTo(300)
        }

//        imageCircle.snp.makeConstraints { make in
//            make.centerX.equalTo(view.snp.centerX)
//            make.centerY.equalTo(view.snp.centerY)
//            make.height.equalTo(300)
//            make.width.equalTo(300)
//        }
    }

}

