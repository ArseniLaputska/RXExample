//
//  SearchBar.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 9.02.23.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UISearchBar {
    
    var isActive: Binder<Bool> {
        return Binder(base, binding: { searchBar, active in
            searchBar.isUserInteractionEnabled = active
            searchBar.backgroundColor = active ? .white : .clear
        })
    }
}

extension UISearchBar {
    func colorImageBar(_ color: UIColor = .systemBlue, _ border: UIColor = .systemBlue) {
        if let textField = self.value(forKey: "searchField") as? UITextField {
            
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 10
            textField.layer.borderColor = border.cgColor
            textField.textColor = .black
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = color
            }
        }
    }
}
