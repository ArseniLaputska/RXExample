//
//  ProgressHUD.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 9.02.23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProgressHUD: UIVisualEffectView {
    var theme: UIBlurEffect.Style = .dark

    let activityIndicator = UIActivityIndicatorView()

    init(theme: UIBlurEffect.Style = .dark) {
        super.init(effect: UIBlurEffect(style: theme))

        self.theme = theme

        contentView.addSubview(activityIndicator)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if let superview = self.superview {
            frame = CGRect(x: superview.frame.midX - 35,
                           y: superview.frame.midY - 35, width: 70, height: 70)

            layer.cornerRadius = 15.0
            layer.masksToBounds = true

            activityIndicator.frame = CGRect(x: 12, y: 12, width: 46, height: 46)
            activityIndicator.style = .large
            activityIndicator.color = .lightGray
        }
    }

    func show() {
        activityIndicator.startAnimating()
        isHidden = false
    }

    func hide() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}

extension Reactive where Base: ProgressHUD {
    var isAnimating: Binder<Bool> {
        return Binder(base, binding: { progressHUD, visible in
            if visible {
                progressHUD.show()
            } else {
                progressHUD.hide()
            }
        })
    }
}
