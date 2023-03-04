//
//  ViewController.swift
//  Lesson 15 - UIButton - Timer
//
//  Created by Валентин Ремизов on 03.03.2023.
//

import UIKit

class StopwatchVC: UIViewController {
    private let timerLabel = UILabel()
    private let startOrPauseButton = UIButton(frame: CGRect(x: 50,
                                                            y: 400,
                                                            width: 75,
                                                            height: 75))
    private let stopButton = UIButton()
    private var timer = Timer()
    private var isStartTimer = false
    private var count = 0.00

    override func viewDidLoad() {
        super.viewDidLoad()
        createTimerLabel()
        createStartOrPauseButton()
        createStopButton()
        [timerLabel, startOrPauseButton, stopButton].forEach{view.addSubview($0)}
    }

//MARK: - Create properties
    fileprivate func createTimerLabel() {
        timerLabel.frame = CGRect(x: 50,
                                  y: 200,
                                  width: view.bounds.width - 100,
                                  height: 100)
        timerLabel.text = String(format: "%02d:%02d:%02d", 0, 0, 0)
        timerLabel.font = UIFont.systemFont(ofSize: 60)
        timerLabel.textAlignment = .center
    }

    fileprivate func createStartOrPauseButton() {
        startOrPauseButton.setTitle("Start", for: .normal)
        startOrPauseButton.backgroundColor = .white
        startOrPauseButton.setTitleColor(.black, for: .normal)
        startOrPauseButton.addTarget(self,
                                     action: #selector(startOrPausePressed),
                                     for: .touchUpInside)
        startOrPauseButton.layer.cornerRadius = startOrPauseButton.bounds.height / 2
        //borderWidth - делает обводку кнопки и ниже выбирается цвет обводки
        startOrPauseButton.layer.borderWidth = 4
        startOrPauseButton.layer.borderColor = UIColor.systemGreen.cgColor
    }

//MARK: - Methods
    @objc private func startOrPausePressed() {
        if isStartTimer == false {
            startOrPauseButton.setTitle("Pause", for: .normal)
            startOrPauseButton.layer.borderColor = UIColor.systemYellow.cgColor
            timer = Timer.scheduledTimer(timeInterval: 0.1,
                                         target: self,
                                         selector: #selector(timerUpdate),
                                         userInfo: Date(),
                                         repeats: true)
            isStartTimer = true
        } else {
            startOrPauseButton.setTitle("Start", for: .normal)
            startOrPauseButton.layer.borderColor = UIColor.systemGreen.cgColor
            //Пауза счетчика таймера
            timer.invalidate()
            isStartTimer = false
        }
    }

    @objc private func timerUpdate() {
        count += 0.1
        //"%02d" - означает формат с 2 цифрами, "%.0f" - с 1 цифрой, а двоеточие как разделитель между ними.
        timerLabel.text = String(format: "%02d:%02d:%02d",
                                 Int(Int(count) / 360),
                                 Int((Int(count) % 3600) / 60),
                                 Int(Int(count) % 3600) % 60)
    }

    fileprivate func createStopButton() {
        stopButton.frame = CGRect(x: view.bounds.width - 125,
                                  y: 400,
                                  width: 75,
                                  height: 75)
        stopButton.setTitle("Stop", for: .normal)
        stopButton.backgroundColor = .white
        stopButton.setTitleColor(.black, for: .normal)
        stopButton.layer.cornerRadius = stopButton.bounds.height / 2
        stopButton.layer.borderWidth = 4
        stopButton.layer.borderColor = UIColor.red.cgColor
        stopButton.addTarget(self,
                             action: #selector(stopPressed),
                             for: .touchUpInside)
    }

    @objc private func stopPressed() {
        count = 0.00
        timerLabel.text = String(format: "%02d:%02d:%02d", 0, 0, 0)
    }
}

