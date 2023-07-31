//
//  ViewController.swift
//  Tracker
//
//  Created by Semen Kocherga on 27.07.2023.
//

import UIKit

final class TrackersViewController: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var addButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 18,
                    weight: .bold
                )
            )!,
            target: self,
            action: #selector(didTapPlusButton))
        button.tintColor = .ypBlackDay
        return button
    }()
    
    private lazy var tittleLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypWhiteDay
        configureView()
        configureConstraints()
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapPlusButton() {
        print("Plus tapped")
    }
}

    //MARK: - Layout methods
private extension TrackersViewController {
    func configureView() {
        view.backgroundColor = .ypWhiteDay
        view.addSubview(addButton)
        view.addSubview(tittleLabel)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tittleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(equalTo: tittleLabel.leadingAnchor),
            tittleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tittleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13)
        ])
    }
}
