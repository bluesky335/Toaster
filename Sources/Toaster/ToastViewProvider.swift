//
//  ToastViewProvider.swift
//
//
//  Created by BlueSky335 on 2023/3/21.
//

import UIKit

public final class ToastViewProvider: ToastViewProviderType<Toast> {
    @MainActor override public func viewForToast(toast: Toast) -> UIView {
        let view = ToastView()
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
