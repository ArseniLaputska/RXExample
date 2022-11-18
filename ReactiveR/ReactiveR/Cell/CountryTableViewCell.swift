//
//  CountryTableViewCell.swift
//  ReactiveR
//
//  Created by Arseni Laputska on 10.11.22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var stringView: UIView!
    @IBOutlet weak var descrLabel: UILabel!
    
    func setupView(with model: University) {
        stringView.layer.cornerRadius = 5
        descrLabel.text = model.description
    }
}
