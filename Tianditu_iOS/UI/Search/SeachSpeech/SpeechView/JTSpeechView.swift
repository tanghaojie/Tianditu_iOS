//
//  SpeechView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/6/19.
//  Copyright © 2018年 JT. All rights reserved.
//

import Speech
import JTFramework

@available(iOS 10.0, *)
class JTSpeechView: UIView, JTNibLoader {
    private var longPress: UILongPressGestureRecognizer?
    private var jtSpeech: JTSpeech?
    @IBOutlet weak var speechResult: UILabel!
    @IBOutlet weak var speechButton: UIButton!
    weak var delegate: JTSpeechViewDelegate?
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        do {
            try jtSpeech = JTSpeech(locale: Locale.current)
            jtSpeech?.delegate = self
        } catch {
            setupSpeech(isEnable: false)
            setup(text: "Speech can not use")
        }
        setupSpeech(isEnable: false)
        setup(text: "")
        setupAuthorize()
        setupRecogizer()
    }
    @IBAction func okTouchUpInside(_ sender: Any) {
        var text = ""
        if let t = speechResult.text {
            text = t
        }
        delegate?.speech(text: text)
    }
}
@available(iOS 10.0, *)
extension JTSpeechView: JTSpeechDelegate {
    func availabilityDidChange(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        setupSpeech(isEnable: available)
    }
}
@available(iOS 10.0, *)
extension JTSpeechView {
    private func setupSpeech(isEnable: Bool) {
        speechButton.isEnabled = isEnable
        longPress?.isEnabled = isEnable
    }
    private func setup(text: String) {
        speechResult.text = text
    }
}
@available(iOS 10.0, *)
extension JTSpeechView {
    private func setupRecogizer() {
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        guard let l = longPress else { return }
        l.minimumPressDuration = 0
        speechButton.addGestureRecognizer(l)
    }
    @objc private func longPressed(press: UILongPressGestureRecognizer) {
        if press.state == .began {
            print("began")
            guard let s = jtSpeech else { return }
            setup(text: "")
            try? s.start() {
                [weak self]
                text, _ in
                self?.setup(text: text)
            }
        } else if press.state == .ended {
            print("ended")
            guard let s = jtSpeech else { return }
            s.stop()
        }
    }
}
@available(iOS 10.0, *)
extension JTSpeechView {
    private func setupAuthorize() {
        SFSpeechRecognizer.requestAuthorization() {
            [weak self]
            status in
            var msg: String? = nil
            var authorizaed = false
            switch status {
            case .notDetermined:
                msg = "Speech recognition not yet authorized"
                authorizaed = false
            case .denied:
                msg = "User denied access to speech recognition"
                authorizaed = false
            case .restricted:
                msg = "Speech recognition restricted on this device"
                authorizaed = false
            case .authorized:
                msg = nil
                authorizaed = true
            @unknown default:
                fatalError()
            }
            OperationQueue.main.addOperation {
                self?.setupSpeech(isEnable: authorizaed)
                if let m = msg {
                    self?.setup(text: m)
                }
            }
        }
    }
}
protocol JTSpeechViewDelegate: NSObjectProtocol {
    func speech(text: String)
}
