//
//  FunctionView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/12.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit

class FunctionView: UIView {
    
    let pageWidth: CGFloat = 288
    private let topViewHeight: CGFloat = 200
    private let headerImageViewWidthHeight: CGFloat = 100
    private let leftView = UIView()
    private let rightView = UIView()
    private let topView = UIView()
    private let headerImageView = UIImageView()
    private var headPortraitFile: URL? = {
        return JTFile.shareInstance.documentURL?.appendingPathComponent("HeadPortrait").appendingPathComponent("head")
    }()

    init() {
        super.init(frame: CGRect.zero)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        setupUI()
        setupGestureRecognizer()
        
        showHeadPortrait()
    }
    
}
extension FunctionView {
    func didFinishAnimation() {
        rightView.alpha = 0.3
    }
}
extension FunctionView {
    private func setupGestureRecognizer() {
        setupRightViewTap()
        setupHeaderImageViewTap()
    }
    private func setupRightViewTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(rightViewTaped))
        rightView.addGestureRecognizer(tap)
    }
    @objc private func rightViewTaped() {
        removeFromSuperview()
    }
    private func setupHeaderImageViewTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(headerImageViewTaped))
        headerImageView.addGestureRecognizer(tap)
    }
    @objc private func headerImageViewTaped() {
        showImagePicker()
    }
}
extension FunctionView {
    private func setupUI() {
        setupLeft()
        setupRight()
        setupTopView()
        setupHeaderImageView()
    }
    private func setupLeft() {
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.backgroundColor = .red
        addSubview(leftView)
        addConstraints([
            NSLayoutConstraint(item: leftView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: leftView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0)])
        leftView.addConstraint(NSLayoutConstraint(item: leftView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: pageWidth))
    }
    private func setupRight() {
        rightView.translatesAutoresizingMaskIntoConstraints = false
        rightView.backgroundColor = .black
        rightView.alpha = 0
        addSubview(rightView)
        addConstraints([
            NSLayoutConstraint(item: rightView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightView, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: rightView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0)])
    }
    private func setupTopView() {
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.backgroundColor = .blue
        leftView.addSubview(topView)
        leftView.addConstraints([
            NSLayoutConstraint(item: topView, attribute: .top, relatedBy: .equal, toItem: leftView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: topView, attribute: .left, relatedBy: .equal, toItem: leftView, attribute: .left, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: topView, attribute: .right, relatedBy: .equal, toItem: leftView, attribute: .right, multiplier: 1, constant: 0)
            ])
        topView.addConstraint(NSLayoutConstraint(item: topView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: topViewHeight))
    }
    private func setupHeaderImageView() {
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.isUserInteractionEnabled = true
        headerImageView.layer.masksToBounds = true
        headerImageView.layer.cornerRadius = headerImageViewWidthHeight / 2
        topView.addSubview(headerImageView)
        headerImageView.addConstraints([
            NSLayoutConstraint(item: headerImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerImageViewWidthHeight),
            NSLayoutConstraint(item: headerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: headerImageViewWidthHeight)
            ])
        topView.addConstraints([
            NSLayoutConstraint(item: headerImageView, attribute: .centerX, relatedBy: .equal, toItem: topView, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: headerImageView, attribute: .centerY, relatedBy: .equal, toItem: topView, attribute: .centerY, multiplier: 1, constant: 0)
            ])
    }
}
extension FunctionView {
    private func showHeadPortrait() {
        let dispatchQueue = DispatchQueue(label: "queue_functionView")
        dispatchQueue.async {
            [weak self] in
            guard let this = self else { return }
            guard let fileUrl = this.headPortraitFile else { return }
            var image: UIImage?
            image = UIImage(contentsOfFile: fileUrl.path)
            if image == nil {
                image = Assets.defaultHeadPortrait
            }
            DispatchQueue.main.sync {
                [weak self] in
                self?.headerImageView.image = image
            }
        }
    }
}
extension FunctionView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func showImagePicker() {
        let actionAlbum = UIAlertAction(title: LocalizableStrings.photoLibrary, style: .default) {
            [weak self] action -> Void in
            guard let this = self else { return }
            guard let responder = this.jtGetResponder() else { return }
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                responder.jtAlertWithUIAlertAction(title: LocalizableStrings.warn, message: LocalizableStrings.photoLibraryDisable, uiAlertAction: [UIAlertAction(title: LocalizableStrings.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .savedPhotosAlbum
            responder.jtTopViewController().present(picker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: LocalizableStrings.takePhoto, style: .default) {
            [weak self] action -> Void in
            guard let this = self else { return }
            guard let responder = this.jtGetResponder() else { return }
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                responder.jtAlertWithUIAlertAction(title: LocalizableStrings.warn, message: LocalizableStrings.cameraDisable, uiAlertAction: [UIAlertAction(title: LocalizableStrings.ok, style: UIAlertActionStyle.default, handler: nil)])
                return
            }
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .camera
            responder.jtTopViewController().present(picker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: LocalizableStrings.cancel, style: .cancel, handler: nil)
        let actionController = UIAlertController(title: LocalizableStrings.selectHeadPortrait, message: LocalizableStrings.takePhotoOrFromPhotoLibrary, preferredStyle: .actionSheet)
        actionController.addAction(actionAlbum)
        actionController.addAction(actionCamera)
        actionController.addAction(actionCancel)
        guard let responder = jtGetResponder() else { return }
        responder.jtTopViewController().present(actionController, animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let responder = jtGetResponder() else { return }
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            responder.jtAlertWithUIAlertAction(title: LocalizableStrings.error, message: LocalizableStrings.doNotGetPortrait, uiAlertAction: [UIAlertAction(title: LocalizableStrings.ok, style: UIAlertActionStyle.default, handler: nil)])
            return
        }
        let hud = responder.view.jtMBProgressHUD_Indeterminate()
        let dataAndExt = image.jtData()
        guard let data = dataAndExt.0, let fileUrl = headPortraitFile else {
            hud.hide(animated: true)
            responder.jtAlertWithUIAlertAction(title: LocalizableStrings.error, message: LocalizableStrings.saveHeadPortraitFailed, uiAlertAction: [UIAlertAction(title: LocalizableStrings.ok, style: UIAlertActionStyle.default, handler: nil)])
            return
        }
        _ = JTFile.shareInstance.deleteFile(url: fileUrl)
        guard JTFile.shareInstance.saveFile(url: fileUrl, data: data) else {
            hud.hide(animated: true)
            responder.jtAlertWithUIAlertAction(title: LocalizableStrings.error, message: LocalizableStrings.saveHeadPortraitFailed, uiAlertAction: [UIAlertAction(title: LocalizableStrings.ok, style: UIAlertActionStyle.default, handler: nil)])
            return
        }
        hud.hide(animated: true)
        showHeadPortrait()
    }
    
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
