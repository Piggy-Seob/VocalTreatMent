//
//  PhonationTimeViewController.swift
//  VocalTreatment
//
//  Created by 박진섭 on 2022/07/11.
//


import UIKit
import SnapKit

final class PhonationTimeViewController: UIViewController {
	private let timeLabel = UILabel()
	private let timeControlStack = UIStackView()
	private let plusButton = UIButton()
	private let minusButton = UIButton()
	private let playButton = UIButton()

	private let cookieBox = UIView()
	private let eaterBox = UIView()

	private var distance = 0
	private var time = 0
	private var isRunning = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
		configureUI()
		configureActionHandlers()
    }

	private func configureUI() {
		navigationItem.title = "연장발성"
		configureMovingContents()
		configureButtons()
	}

	private func configureMovingContents() {
		cookieBox.layer.cornerRadius = 50
		cookieBox.backgroundColor = .systemBrown

		view.addSubview(cookieBox)

		cookieBox.snp.makeConstraints { make in
			make.size.equalTo(100)
			make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
			make.centerX.equalTo(view.safeAreaLayoutGuide)
		}

		eaterBox.backgroundColor = .systemBlue

		view.addSubview(eaterBox)

		eaterBox.snp.makeConstraints { make in
			make.top.equalTo(cookieBox.snp.bottom).offset(200)
			make.centerX.equalTo(view.safeAreaLayoutGuide)
			make.size.equalTo(50)
		}
	}

	private func configureButtons() {
		plusButton.setTitle("+30", for: .normal)
		plusButton.backgroundColor = .systemMint
		plusButton.layer.cornerRadius = 10

		minusButton.setTitle("-30", for: .normal)
		minusButton.backgroundColor = .systemPink
		minusButton.layer.cornerRadius = 10

		let timeControlStack = UIStackView(arrangedSubviews: [plusButton, minusButton])

		timeControlStack.axis = .horizontal
		timeControlStack.distribution = .fillEqually
		timeControlStack.spacing = 16

		timeControlStack.snp.makeConstraints { make in
			make.height.equalTo(50)
		}

		self.changeTimeLabel()
		timeLabel.textAlignment = .center

		playButton.setTitle("Play", for: .normal)
		playButton.layer.cornerRadius = 10
		playButton.isEnabled = time > 0
		playButton.backgroundColor = playButton.isEnabled ? .systemGreen : .systemGray4

		let stack = UIStackView(arrangedSubviews: [timeLabel, timeControlStack, playButton])

		stack.axis = .vertical
		stack.distribution = .fillProportionally
		stack.spacing = 16

		view.addSubview(stack)

		stack.snp.makeConstraints { make in
			make.centerX.equalTo(view.safeAreaLayoutGuide)
			make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
			make.height.equalTo(160)
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
		}
	}

	private func configureActionHandlers() {
		playButton.addAction(.init(handler: { [weak self] _ in
			guard let self = self else { return }

			if self.isRunning {
				self.playButton.setTitle("Play", for: .normal)
				self.playButton.backgroundColor = .systemGreen

				self.eaterBox.layer.removeAllAnimations()
			} else {
				self.playButton.setTitle("Stop", for: .normal)
				self.playButton.backgroundColor = .systemRed

				UIView.animate(withDuration: 1, delay: 0) {
					self.eaterBox.center.y += 100
				}
			}

			self.isRunning.toggle()
		}), for: .touchUpInside)

		plusButton.addAction(.init(handler: { [weak self] _ in
			guard let self = self else { return }

			self.time += 30
			self.changeTimeLabel()

			if !self.playButton.isEnabled {
				self.enablePlayButton()
			}
		}), for: .touchUpInside)

		minusButton.addAction(.init(handler: { [weak self] _ in
			guard let self = self else { return }

			self.time = max(self.time - 30, 0)
			self.changeTimeLabel()

			if self.time == 0 {
				self.disablePlayButton()
			}
		}), for: .touchUpInside)
	}

	private func changeTimeLabel() {
		self.timeLabel.text = "남은 시간: \(String(time))초"
	}

	private func disablePlayButton() {
		self.playButton.isEnabled = false
		self.playButton.backgroundColor = .systemGray4
	}

	private func enablePlayButton() {
		self.playButton.isEnabled = true
		self.playButton.backgroundColor = .systemGreen
	}
}
