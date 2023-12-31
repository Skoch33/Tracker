//
//  UIStackView+Extension.swift
//  Tracker
//
//  Created by Semen Kocherga on 4.08.2023.
//

import UIKit

extension UIStackView {
    
    func configurePlaceholderStack(imageName: String, text: String){
        self.contentMode = .scaleAspectFit
        self.layer.masksToBounds = true
        let imageView = UIImageView(image: UIImage(named: imageName))
        imageView.layer.frame = CGRect(origin: .zero, size: CGSize(width: 80, height: 80))
        let label = UILabel()
        label.textColor = .ypBlackDay
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = text
        label.textAlignment = .center
        self.addArrangedSubview(imageView)
        self.addArrangedSubview(label)
        self.axis = .vertical
        self.alignment = .center
        self.spacing = 8
    }
}
