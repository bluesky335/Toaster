//
//  ToastViewProvider.swift
//
//
//  Created by BlueSky335 on 2023/3/21.
//

import UIKit

public final class ToastViewProvider: ToastViewProviderType<Toast> {
    @MainActor override public func viewForToast(toast: Toast) -> UIView {
        let view = ToastView(contentInset: toast.style.inset)
        if let text = toast.text {
            view.label.text = text
        }
        if let attributedText = toast.attributedText {
            view.label.attributedText = attributedText
        }
        view.setStyle(toast.style)
        ToastCenter.default.register(toastType: Toast.self, with: ToastViewProvider())
        return view
    }
}

extension ToastView {
    public func setStyle(_ style: Toast.Style) {
        backgroundColor = style.backgroundColor
        label.font = style.font
        label.textColor = style.textColor
        layer.cornerRadius = style.cornerRadius
        if let efect = style.efect {
            setupEfect(style: efect)
            efectView.layer.cornerRadius = style.cornerRadius
            efectView.layer.masksToBounds = true
            efectView.backgroundColor = style.backgroundColor
            backgroundColor = .clear
        }
    }
}
