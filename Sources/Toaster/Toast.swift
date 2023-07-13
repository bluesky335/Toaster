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
        public var backgroundColor: UIColor
        public var font: UIFont
        public var textColor: UIColor
        public var cornerRadius: CGFloat
        public var efect: UIBlurEffect.Style?
        public var inset: UIEdgeInsets

        public init(backgroundColor: UIColor = .darkGray,
                    font: UIFont = .systemFont(ofSize: 17),
                    textColor: UIColor = .white,
                    cornerRadius: CGFloat = 10,
                    efect: UIBlurEffect.Style? = nil,
                    inset: UIEdgeInsets = .init(top: 3, left: 10, bottom: 3, right: 10)) {
            self.backgroundColor = backgroundColor
            self.font = font
            self.textColor = textColor
            self.cornerRadius = cornerRadius
            self.efect = efect
            self.inset = inset
        }
    }

    public static var successStyle: Style = .init(backgroundColor: .systemGreen.withAlphaComponent(0.75), efect: .regular)
    public static var errorStyle: Style = .init(backgroundColor: .systemRed.withAlphaComponent(0.75), efect: .regular)
    public static var warningStyle: Style = .init(backgroundColor: .systemYellow.withAlphaComponent(0.75), textColor: .darkGray, efect: .regular)
    public static var defaultStyle: Style = .init(backgroundColor: .clear, efect: .dark)

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
