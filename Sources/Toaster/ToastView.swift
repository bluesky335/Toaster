//
//  ToastView.swift
//
//
//  Created by BlueSky335 on 2023/3/21.
//

import UIKit

@MainActor open class ToastView: UIView {
    open var label = UILabel()

    open var contentInset: UIEdgeInsets

    open lazy var efectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(view, at: 0)
        self.removeConstraints(self.constraints)
        label.removeConstraints(label.constraints)
        label.removeFromSuperview()
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        view.contentView.addSubview(label)
        view.layer.cornerRadius = self.layer.cornerRadius
        view.layer.masksToBounds = true
        setupLabelLayout(supperView: view)
        return view
    }()

    public init(contentInset: UIEdgeInsets = .init(top: 3, left: 10, bottom: 3, right: 10)) {
        self.contentInset = contentInset
        super.init(frame: .zero)
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        addSubview(label)
        setupLabelLayout(supperView: self)
    }

    func setupLabelLayout(supperView: UIView) {
        label.leftAnchor.constraint(equalTo: supperView.leftAnchor, constant: contentInset.left).isActive = true
        label.rightAnchor.constraint(equalTo: supperView.rightAnchor, constant: -contentInset.right).isActive = true
        label.topAnchor.constraint(equalTo: supperView.topAnchor, constant: contentInset.top).isActive = true
        label.bottomAnchor.constraint(equalTo: supperView.bottomAnchor, constant: -contentInset.bottom).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: label.font.pointSize).isActive = true
    }

    func setupEfect(style: UIBlurEffect.Style) {
        efectView.effect = UIBlurEffect(style: style)
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
