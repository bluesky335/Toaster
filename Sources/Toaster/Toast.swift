//
//  Toast.swift
//
//
//  Created by BlueSky335 on 2023/3/23.
//

import UIKit

public struct Toast: ToastType {
    public var duration: ToastDuration
    public var text: String?
    public var attributedText: NSAttributedString?

    public struct Style {
        public var backgroundColor: UIColor = .darkGray
        public var font: UIFont = .systemFont(ofSize: 17)
        public var textColor: UIColor = .white
        public var cornerRadius: CGFloat = 10
        public var efect: UIBlurEffect.Style?
        public var inset: UIEdgeInsets = .init(top: 3, left: 10, bottom: 3, right: 10)
    }

    static var successStyle: Style = .init(backgroundColor: .systemGreen.withAlphaComponent(0.75), efect: .regular)
    static var errorStyle: Style = .init(backgroundColor: .systemRed.withAlphaComponent(0.75), efect: .regular)
    static var warningStyle: Style = .init(backgroundColor: .systemYellow.withAlphaComponent(0.75), textColor: .darkGray, efect: .regular)
    static var defaultStyle: Style = .init(backgroundColor: .clear, efect: .dark)

    public var style: Style

    public init(text: String, duration: ToastDuration = .default) {
        style = Self.defaultStyle
        self.text = text
        self.duration = duration
    }

    public init(text: NSAttributedString, duration: ToastDuration = .default) {
        style = Self.defaultStyle
        attributedText = text
        self.duration = duration
    }

    public func success() -> Toast {
        var newToast = self
        newToast.style = Self.successStyle
        return newToast
    }

    public func error() -> Toast {
        var newToast = self
        newToast.style = Self.errorStyle
        return newToast
    }

    public func warning() -> Toast {
        var newToast = self
        newToast.style = Self.warningStyle
        return newToast
    }

    public func customStyle(_ style: Style) -> Toast {
        var newToast = self
        newToast.style = style
        return newToast
    }
}
