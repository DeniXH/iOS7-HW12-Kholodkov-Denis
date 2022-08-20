//
//  ViewController.swift
//  iOS7-HW12-Kholodkov Denis
//
//  Created by Денис Холодков on 20.08.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private lazy var labelTimer: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()

//MARK: Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setConstraints()
    }

    private func setupHierarchy() {
        view.addSubview(labelTimer)
    }

    private func setConstraints() {
        labelTimer.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
            make.centerX.equalTo(view)
        }
    }

}

