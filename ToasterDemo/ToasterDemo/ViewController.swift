//
//  ViewController.swift
//  ToasterDemo
//
//  Created by BlueSky335 on 2023/3/14.
//

import Toaster
import UIKit

class ViewController: UIViewController {
    @IBOutlet var textField: UITextField!
    var toast: Toast?
    @IBOutlet var topSegment: UISegmentedControl!
    @IBOutlet var layoutSegment: UISegmentedControl!
    var tasks: [any ToastTaskType] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        ToastView.appearance().backgroundColor = .blue
        ToastCenter.default.toastAnimator = ToastAnimatter(position: .bottom)
    }

    @IBAction func placeSettingChange(_ sender: UISegmentedControl) {
        guard let animator = ToastCenter.default.toastAnimator as? ToastAnimatter else {
            return
        }
        var place: ToastAnimatter.Position = .bottom
        switch sender.selectedSegmentIndex {
        case 0: place = .bottom
        case 1: place = .center
        case 2: place = .top
        default:
            place = .bottom
        }
        ToastCenter.default.cancellAllToast()
        ToastCenter.default.toastAnimator = ToastAnimatter(position: place, layout: animator.layout, fixedWidth: animator.fixedWidth)
    }

    @IBAction func layoutSettingChange(_ sender: UISegmentedControl) {
        guard let animator = ToastCenter.default.toastAnimator as? ToastAnimatter else {
            return
        }
        var layout: ToastAnimatter.Layout = .replace
        switch sender.selectedSegmentIndex {
        case 0: layout = .default
        case 1: layout = .replace
        case 2: layout = .stacke
        default:
            layout = .replace
        }
        ToastCenter.default.cancellAllToast()
        ToastCenter.default.toastAnimator = ToastAnimatter(position: animator.position, layout: layout, fixedWidth: animator.fixedWidth)
    }

    @IBAction func fixedWidth(_ sender: UIButton) {
        guard let animator = ToastCenter.default.toastAnimator as? ToastAnimatter else {
            return
        }
        sender.isSelected.toggle()
        animator.fixedWidth = sender.isSelected
    }

    @IBAction func showToast(_ sender: Any) {
        if let task = Toast(text: textField.text ?? "xxx").show() {
            tasks.append(task)
        }
    }

    @IBAction func showToastSuccess(_ sender: Any) {
        if let task = Toast(text: textField.text ?? "xxx").success().show() {
            tasks.append(task)
        }
    }

    @IBAction func showToastError(_ sender: Any) {
        if let task = Toast(text: textField.text ?? "xxx").error().show() {
            tasks.append(task)
        }
    }

    @IBAction func showToastWarning(_ sender: Any) {
        if let task = Toast(text: textField.text ?? "xxx").warning().show() {
            tasks.append(task)
        }
    }

    @IBAction func hideToast(_ sender: Any) {
        tasks.forEach { task in
            task.cancell()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
