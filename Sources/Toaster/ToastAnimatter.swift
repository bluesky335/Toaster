//
//  ToastAnimatter.swift
//
//
//  Created by BlueSky335 on 2023/3/21.
//

import UIKit

public class ToastAnimatter: ToastAnimatterType {
    public enum Position {
        case top
        case bottom
        case center
    }

    public enum Layout {
        case `default`
        case replace
        case stacke
    }

    public let position: Position

    public let layout: Layout

    public var fixedWidth: Bool

    public var contentInsets: UIEdgeInsets

    public var stackSpace: CGFloat = 10

    public init(position: Position = .bottom, layout: Layout = .default, fixedWidth: Bool = false, contentInsets: UIEdgeInsets? = nil) {
        self.position = position
        self.layout = layout
        self.fixedWidth = fixedWidth
        self.contentInsets = contentInsets ?? .init(top: 16, left: 16, bottom: 16, right: 16)
    }

    private weak var preToastView: UIView?

    public func show(toastView: UIView, in center: ToastCenter, finish: @escaping () -> Void) {
        toastView.translatesAutoresizingMaskIntoConstraints = false
        let window = center.window
        window.addSubview(toastView)
        if fixedWidth {
            toastView.leftAnchor.constraint(equalTo: window.safeAreaLayoutGuide.leftAnchor, constant: contentInsets.left).isActive = true
            toastView.rightAnchor.constraint(equalTo: window.safeAreaLayoutGuide.rightAnchor, constant: -contentInsets.right).isActive = true
        } else {
            toastView.leftAnchor.constraint(greaterThanOrEqualTo: window.safeAreaLayoutGuide.leftAnchor, constant: contentInsets.left).isActive = true
            toastView.rightAnchor.constraint(lessThanOrEqualTo: window.safeAreaLayoutGuide.rightAnchor, constant: -contentInsets.right).isActive = true
        }
        toastView.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        toastView.alpha = 0
        if position == .bottom {
            toastView.bottomAnchor.constraint(lessThanOrEqualTo: window.safeAreaLayoutGuide.bottomAnchor).isActive = true
            toastView.bottomAnchor.constraint(lessThanOrEqualTo: window.bottomAnchor, constant: -contentInsets.bottom).isActive = true
            toastView.bottomAnchor.constraint(lessThanOrEqualTo: center.keyboardLayoutGuide.topAnchor, constant: -contentInsets.bottom).isActive = true
        } else if position == .top {
            toastView.topAnchor.constraint(greaterThanOrEqualTo: window.safeAreaLayoutGuide.topAnchor, constant: contentInsets.top).isActive = true
        } else if position == .center {
            let center = toastView.centerYAnchor.constraint(lessThanOrEqualTo: window.safeAreaLayoutGuide.centerYAnchor)
            center.isActive = true
            center.priority = .defaultHigh
        }
        if layout == .stacke {
            if position == .bottom || position == .center {
                toastView.transform = .init(translationX: 0, y: 10)
            } else if position == .top {
                toastView.transform = .init(translationX: 0, y: -10)
            }
        }
        window.layoutIfNeeded()
        if layout == .replace {
            center.cancellAllToast()
        } else if layout == .stacke {
            if let preToastView = preToastView, preToastView.superview == window {
                if position == .bottom || position == .center {
                    toastView.transform = .init(translationX: 0, y: 10)
                    preToastView.bottomAnchor.constraint(lessThanOrEqualTo: toastView.topAnchor, constant: -stackSpace).isActive = true
                } else if position == .top {
                    toastView.transform = .init(translationX: 0, y: -10)
                    preToastView.topAnchor.constraint(greaterThanOrEqualTo: toastView.bottomAnchor, constant: stackSpace).isActive = true
                }
            }
        }
        preToastView = toastView
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            toastView.alpha = 1
            toastView.transform = .identity
            window.layoutIfNeeded()
        } completion: { _ in
            finish()
        }
    }

    public func hide(toastView: UIView, in center: ToastCenter, finish: @escaping () -> Void) {
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseIn]) {
            toastView.alpha = 0
            center.window.layoutIfNeeded()
        } completion: { _ in
            finish()
        }
    }
}
