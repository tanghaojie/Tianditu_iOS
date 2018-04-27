//
//  HeadPortraitImageView.swift
//  Tianditu_iOS
//
//  Created by JT on 2018/4/16.
//  Copyright © 2018年 JT. All rights reserved.
//

import UIKit
import JTFramework

class HeadPortraitImageView: UIImageView {
    private var headPortraitFile: URL? = {
        return JTFile.shareInstance.documentURL?.appendingPathComponent("HeadPortrait").appendingPathComponent("head")
    }()
    init() {
        super.init(frame: CGRect.zero)
        setupTap()
        showHeadPortrait()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTap()
        showHeadPortrait()
    }
}
extension HeadPortraitImageView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
        
        let hud = JTHUD(view: responder.view).indeterminate()
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
extension HeadPortraitImageView {
    private func setupTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        self.addGestureRecognizer(tap)
    }
    @objc private func taped() {
        showImagePicker()
    }
}
extension HeadPortraitImageView {
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
                self?.image = image
            }
        }
    }
}
