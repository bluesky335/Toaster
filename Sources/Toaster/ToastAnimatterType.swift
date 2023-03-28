//
//  ToastAnimatterType.swift
//
//
//  Created by BlueSky335 on 2023/3/21.
//

import UIKit

public protocol ToastAnimatterType {
    @MainActor func show(toastView: UIView, in center: ToastCenter, finish: @escaping () -> Void)

    @MainActor func hide(toastView: UIView, in center: ToastCenter, finish: @escaping () -> Void)
}
