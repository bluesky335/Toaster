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
        public var backgroundColor: UIColor = .darkGray.withAlphaComponent(0.8)
        public var font: UIFont = .systemFont(ofSize: 17)
        public var textColor: UIColor = .white
        public var cornerRadius: CGFloat = 10
    }

    static var successStyle: Style = .init(backgroundColor: .systemGreen.withAlphaComponent(0.8))
    static var errorStyle: Style = .init(backgroundColor: .systemRed.withAlphaComponent(0.8))
    static var warningStyle: Style = .init(backgroundColor: .systemYellow.withAlphaComponent(0.8))
    static var defaultStyle: Style = .init()

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

extension ToastView {
    
    public func setStyle(_ style:Toast.Style) {
        self.backgroundColor = style.backgroundColor
        self.label.font = style.font
        self.label.textColor = style.textColor
        self.layer.cornerRadius = style.cornerRadius
    }
}
