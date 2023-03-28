//
//  ToastView.swift
//
//
//  Created by BlueSky335 on 2023/3/21.
//

import UIKit

@MainActor open class ToastView: UIView {
    public dynamic var label = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        layer.cornerRadius = 10
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        addSubview(label)
        label.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        label.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        label.topAnchor.constraint(equalTo: topAnchor, constant: 3).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3).isActive = true
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 15).isActive = true
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
