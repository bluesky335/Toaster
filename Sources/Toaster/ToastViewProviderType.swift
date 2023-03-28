//
//  ToastViewProviderType.swift
//
//
//  Created by BlueSky335 on 2023/3/23.
//

import UIKit

open class ToastViewProviderType<T: ToastType> {
    @MainActor public func viewForToast(toast: T) -> UIView {
        fatalError("Please create a subclass of ToastViewProvider, and rewrite the function: viewForToast(toast:).")
    }
}
