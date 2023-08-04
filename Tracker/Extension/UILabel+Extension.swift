//
//  File.swift
//  Tracker
//
//  Created by Semen Kocherga on 4.08.2023.
//

import UIKit

extension UILabel {
    func configureLabel(text: String, addToView: UIView, ofSize: CGFloat, weight: UIFont.Weight) {
        self.translatesAutoresizingMaskIntoConstraints = false
        addToView.addSubview(self)
        self.text = text
        self.font = UIFont.systemFont(ofSize: ofSize, weight: weight)
        self.textAlignment = .center
        self.textColor = .ypBlackDay
    }
}
