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
    
    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.backgroundColor = .ypWhiteDay
        datePicker.tintColor = .ypBlue
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.calendar = Calendar(identifier: .iso8601)
        return datePicker
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.searchBarStyle = .minimal
        return view
    }()
    
    private lazy var starIcon: UIImageView = {
        let starView = UIImageView()
        starView.image = UIImage(named: "StarIcon")
        return starView
    }()
    
    private let questionlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.text = "Что будем отслеживать?"
        label.textColor = .ypBlackDay
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 8
        return stack
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
        view.addSubview(datePicker)
        view.addSubview(searchBar)
        view.addSubview(stackView)
        stackView.addArrangedSubview(starIcon)
        stackView.addArrangedSubview(questionlabel)
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        tittleLabel.translatesAutoresizingMaskIntoConstraints = false
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        starIcon.translatesAutoresizingMaskIntoConstraints = false
        questionlabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(equalTo: tittleLabel.leadingAnchor),
            tittleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tittleLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 13),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: addButton.bottomAnchor,constant: 13 ),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            searchBar.topAnchor.constraint(equalTo: tittleLabel.bottomAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 45),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
