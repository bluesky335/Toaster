//
//  ToastType.swift
//
//
//  Created by BlueSky335 on 2023/3/23.
//

import Foundation

public struct ToastDuration: RawRepresentable {
    public typealias RawValue = TimeInterval

    public init(rawValue: TimeInterval) {
        self.rawValue = rawValue
    }

    public var rawValue: TimeInterval

    /// 2.5s
    public static var `default`: ToastDuration = .init(rawValue: 2.5)

    /// 1s
    public static var short: ToastDuration = .init(rawValue: 1)

    /// 4s
    public static var long: ToastDuration = .init(rawValue: 4)
}

@MainActor
public protocol ToastType {
    var duration: ToastDuration { get }
}

public extension ToastType {
    @MainActor func show(in toastCenter: ToastCenter = .default) -> ToastTask<Self>? {
        return toastCenter.show(toast: self)
    }
}
