//
//  ToastCenter.swift
//
//
//  Created by BlueSky335 on 2023/3/14.
//

import UIKit
import KeyboardObserver

public protocol ToastTaskType: Hashable {
    var toastView: UIView { get }
    var toastCenter: ToastCenter { get }
    var isCancelled: Bool { get }
    func cancell()
}

public class ToastTask<T: ToastType>: NSObject, ToastTaskType {
    public let toast: T
    public let toastView: UIView
    public fileprivate(set) var isCancelled: Bool = false
    public let toastCenter: ToastCenter

    init(toast: T, toastView: UIView, toastCenter: ToastCenter) {
        self.toast = toast
        self.toastView = toastView
        self.toastCenter = toastCenter
    }

    @MainActor public func cancell() {
        guard !isCancelled else {
            return
        }
        toastCenter.cancell(toastTask: self)
    }
}


public class ToastCenter {
    public static var `default` = ToastCenter()
    private var toastBag: [Int: any ToastTaskType] = [:]
    public let window: ToastWindow

    public var toastAnimator: ToastAnimatterType = ToastAnimatter()

    private(set) var viewProviders: [String: Any] = [:]

    public let keyboardLayoutGuide = UILayoutGuide()

    private var keyboardLeft: NSLayoutConstraint?
    private var keyboardRight: NSLayoutConstraint?
    private var keyboardHeight: NSLayoutConstraint?
    private var keyboardBottom: NSLayoutConstraint?

    public init() {
        if #available(iOS 13.0, *) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene }) as? UIWindowScene {
                window = ToastWindow(windowScene: scene)
            } else {
                window = ToastWindow()
            }
        } else {
            window = ToastWindow()
        }
        setup()
    }

    @available(iOS 13.0, *)
    public init(windowScene: UIWindowScene) {
        window = ToastWindow(windowScene: windowScene)
        setup()
    }

    public func register<Toast: ToastType>(toastType: Toast.Type, with viewProvider: ToastViewProviderType<Toast>) {
        let typeName = "\(toastType)"
        viewProviders[typeName] = viewProvider
    }

    public func unregister<Toast: ToastType>(toast toastType: Toast.Type) {
        let typeName = "\(toastType)"
        viewProviders.removeValue(forKey: typeName)
    }

    public func toastViewProvider<Toast: ToastType>(for toastType: Toast.Type) -> ToastViewProviderType<Toast>? {
        let typeName = "\(toastType)"
        return viewProviders[typeName] as? ToastViewProviderType<Toast>
    }

    func setup() {
        window.isHidden = false
        window.windowLevel = .init(rawValue: UIWindow.Level.statusBar.rawValue + 1)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.isUserInteractionEnabled = false
        window.addLayoutGuide(keyboardLayoutGuide)
        keyboardLeft = keyboardLayoutGuide.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 0)
        keyboardLeft?.isActive = true
        keyboardRight = keyboardLayoutGuide.rightAnchor.constraint(equalTo: window.rightAnchor, constant: 0)
        keyboardRight?.isActive = true
        
        keyboardHeight = keyboardLayoutGuide.heightAnchor.constraint(equalToConstant: KeyboardObserver.share().keyboardEndFrame.height)
        keyboardHeight?.isActive = true
        keyboardBottom = keyboardLayoutGuide.bottomAnchor.constraint(equalTo: window.bottomAnchor, constant: 0)
        keyboardBottom?.isActive = true
        // 注册一个默认的 ToastViewProvider
        register(toastType: Toast.self, with: ToastViewProvider())
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillShowNotification, object: nil, queue: .main) { notification in
            guard let frame = notification.userInfo?[UIApplication.keyboardFrameEndUserInfoKey] as? CGRect, let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat else {
                return
            }
            self.keyboardHeight?.constant = frame.height
            UIView.animate(withDuration: duration, delay: 0) {
                self.window.layoutIfNeeded()
            }
            print(notification)
        }

        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillHideNotification, object: nil, queue: .main) { notification in
            guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? CGFloat else {
                return
            }
            self.keyboardHeight?.constant = 0
            UIView.animate(withDuration: duration, delay: 0) {
                self.window.layoutIfNeeded()
            }
            print(notification)
        }
    }

    @MainActor @discardableResult
    public func show<T: ToastType>(toast: T) -> ToastTask<T>? {
        guard let viewProvider = toastViewProvider(for: T.self) else {
            NSLog("Warning, there is no ToastViewProvider registered for toast type '\(T.self)'")
            return nil
        }
        let view = viewProvider.viewForToast(toast: toast)
        let task = ToastTask(toast: toast, toastView: view, toastCenter: self)
        toastAnimator.show(toastView: view, in: self) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(toast.duration.rawValue * 1000))) {
                if !task.isCancelled {
                    task.cancell()
                }
            }
        }
        toastBag[task.hash] = task
        return task
    }

    @MainActor public func cancell<T: ToastType>(toastTask: ToastTask<T>) {
        toastTask.isCancelled = true
        toastAnimator.hide(toastView: toastTask.toastView, in: self) { [weak self] in
            self?.toastBag.removeValue(forKey: toastTask.hash)
            toastTask.toastView.removeFromSuperview()
        }
    }

    @MainActor public func cancellAllToast() {
        toastBag.values.forEach { task in
            task.cancell()
        }
    }
}
