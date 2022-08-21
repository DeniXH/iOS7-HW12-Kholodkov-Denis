//
//  ViewController.swift
//  iOS7-HW12-Kholodkov Denis
//
//  Created by Денис Холодков on 20.08.2022.
//

import UIKit

final class ViewController: UIViewController {

    var circlePaint = CirclePaint(frame: CGRect(x: 0,
                                                y: 0,
                                                width: ViewController.progressBarWidth,
                                                height: ViewController.progressBarWidth))

    private var isWorkTime = true
    private var isStarted = false
    var timer = Timer()

    var settingTime = SettingTime()
    var time = Int()
    static let progressBarWidth: CGFloat = 300

    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont(name: "courier new", size: 50)
        return label
    }()

    private lazy var buttonPlay: UIButton = {
        let buttonPlay = UIButton()
        let image = UIImage(systemName: "play")
        buttonPlay.setImage(image, for: .normal)
        buttonPlay.frame.size = CGSize(width: 40, height: 40)
        buttonPlay.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 50, weight: UIImage.SymbolWeight.heavy), forImageIn: .normal)
        buttonPlay.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return buttonPlay
    }()

    private lazy var progressContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.mainViewBackgroundColor
        return view
    }()

    //MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setConstraints()
        labelTimer.text = timeFormat()
    }

    private func setupView() {
        view.backgroundColor = .white
        settingTime.setWorkTime(in: 20)
        settingTime.setRestTime(in: 5)
        time = settingTime.timeModel.timeToWork

        setupHierarchy()
        circlePaint.createCircularPath(toneColor: Colors.workColor)
    }

    @objc private func playButtonAction() {
        if !isStarted {
            labelTimer.text = timeFormat()
            isStarted = true
            startTimer()
            buttonPlay.setImage(UIImage(systemName: "pause"), for: .normal)
            circlePaint.progressAnimation(duration: TimeInterval(time))
        } else {
            timer.invalidate()
            if let presentation = circlePaint.progressLayer.presentation() {
                circlePaint.progressLayer.strokeEnd = presentation.strokeEnd
            }
            circlePaint.progressLayer.removeAnimation(forKey: "progressAnimation")
            isStarted = false
            buttonPlay.setImage(UIImage(systemName: "play"), for: .normal)
        }
    }

    // MARK: - Change interface

    private func workTimeInterface() {
        circlePaint.createCircularPath(toneColor: Colors.workColor)
        buttonPlay.tintColor = UIColor(cgColor: Colors.workColor)
    }

    private func restTimeInterface() {
        circlePaint.createCircularPath(toneColor: Colors.restColor)
        buttonPlay.tintColor = UIColor(cgColor: Colors.restColor)
    }

    private func changeInterface() {
        if isWorkTime {
            restTimeInterface()
            isWorkTime = false
        } else {
            workTimeInterface()
            isWorkTime = true
        }
        resetTime()
    }

    private func timeFormat() -> String {
        let min = time / 60 % 60
        let sec = time % 60
        return String(format: "%02i:%02i", min, sec)
    }

    private func isStartedCheck() {
        if isStarted {
            circlePaint.progressAnimation(duration: TimeInterval(time))
        }
    }

    private func resetTime() {
        if isWorkTime {
            time = settingTime.timeModel.timeToWork
            circlePaint.createCircularPath(toneColor: Colors.workColor)
            isStartedCheck()
        } else {
            time = settingTime.timeModel.timeToRest
            circlePaint.createCircularPath(toneColor: Colors.restColor)
            isStartedCheck()
        }
        labelTimer.text = timeFormat()
    }

    // MARK: - Timer

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: (#selector(updateTimer)),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc private func updateTimer() {
        guard time > 0 else {
            changeInterface()
            return
        }
        time -= 1
        labelTimer.text = timeFormat()
    }

    // MARK: - Setup Layout

    private func setupHierarchy() {
        view.addSubview(progressContainer)
        view.addSubview(labelTimer)
        progressContainer.addSubview(circlePaint)
        progressContainer.addSubview(buttonPlay)
    }

    private func setConstraints() {
        progressContainer.translatesAutoresizingMaskIntoConstraints = false
        progressContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        progressContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -20).isActive = true
        progressContainer.heightAnchor.constraint(equalToConstant: ViewController.progressBarWidth).isActive = true
        progressContainer.widthAnchor.constraint(equalToConstant: ViewController.progressBarWidth).isActive = true

        labelTimer.translatesAutoresizingMaskIntoConstraints = false
        labelTimer.centerXAnchor.constraint(equalTo: progressContainer.centerXAnchor).isActive = true
        labelTimer.centerYAnchor.constraint(equalTo: progressContainer.centerYAnchor, constant: -40).isActive = true

        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.centerXAnchor.constraint(equalTo: progressContainer.centerXAnchor).isActive = true
        buttonPlay.centerYAnchor.constraint(equalTo: progressContainer.centerYAnchor, constant: ViewController.progressBarWidth / 5).isActive = true
    }
}

struct TimeModel {
    var timeToWork: Int = 1500
    var timeToRest: Int = 300
}

class SettingTime {

    var timeModel = TimeModel()

    func setWorkTime(in time: Int) {
        timeModel.timeToWork = time
    }

    func setRestTime(in time: Int) {
        timeModel.timeToRest = time
    }
}
