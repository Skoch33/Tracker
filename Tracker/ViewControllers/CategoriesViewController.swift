//
//  CategoriesViewController.swift
//  Tracker
//
//  Created by Semen Kocherga on 5.09.2023.
//

import UIKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func didConfirm(_ category: TrackerCategory)
}

final class CategoriesViewController: UIViewController {
    
    // MARK: - Layout elements
    
    private let categoriesView: UITableView = {
        let table = UITableView()
        table.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.identifier)
        table.separatorStyle = .none
        table.allowsMultipleSelection = false
        table.backgroundColor = .clear
        table.isScrollEnabled = true
        table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        return table
    }()
    
    private let starCombined = UIStackView()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("SetCategoriesViewController.addButton", comment: "Add category"), for: .normal)
        button.setTitleColor(.ypBlackNight, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.backgroundColor = .ypBlackDay
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    weak var delegate: CategoriesViewControllerDelegate?
    private let viewModel: CategoriesViewModel
    
    // MARK: - Lifecycle
    
    init(selectedCategory: TrackerCategory?) {
        viewModel = CategoriesViewModel(selectedCategory: selectedCategory)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        viewModel.delegate = self
        viewModel.loadCategories()
        starCombined.configurePlaceholderStack(imageName: "StarIcon", text: NSLocalizedString("SetCategoriesViewController.starCombined", comment: "Combined"))
    }
    
    // MARK: - Actions
    
    @objc
    private func didTapAddButton() {
        let addCategoryViewController = CategoryFormViewController()
        addCategoryViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: addCategoryViewController)
        present(navigationController, animated: true)
    }
    
    // MARK: - Private
    
    private func editCategory(_ category: TrackerCategory) {
        let addCategoryViewController = CategoryFormViewController(data: category.data)
        addCategoryViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: addCategoryViewController)
        present(navigationController, animated: true)
    }
    
    private func deleteCategory(_ category: TrackerCategory) {
        let alert = UIAlertController(
            title: nil,
            message: NSLocalizedString("SetCategoriesViewController.deleteCategory", comment: "Delete category"),
            preferredStyle: .actionSheet
        )
        let cancelAction = UIAlertAction(title: NSLocalizedString("TrackerFormViewController.cancel", comment: "Cancel"), style: .cancel)
        let deleteAction = UIAlertAction(title: NSLocalizedString("SetCategoriesViewController.delete", comment: "Delete"), style: .destructive) { [weak self] _ in
            self?.viewModel.deleteCategory(category)
        }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

// MARK: - Layout methods

private extension CategoriesViewController {
    func configureViews() {
        title = NSLocalizedString("SetTrackersViewController.parameter1", comment: "Category")
        view.backgroundColor = .ypWhiteDay
        [categoriesView, addButton, starCombined].forEach { view.addSubview($0) }
        
        categoriesView.dataSource = self
        categoriesView.delegate = self
        
        categoriesView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        starCombined.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            categoriesView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoriesView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            categoriesView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoriesView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -16),
            addButton.leadingAnchor.constraint(equalTo: categoriesView.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: categoriesView.trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 60),
            starCombined.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            starCombined.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            starCombined.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

// MARK: - UITableViewDataSource

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier) as? CategoryCell else { return UITableViewCell() }
        let category = viewModel.categories[indexPath.row]
        let isSelected = viewModel.selectedCategory == category
        var position: ListOfItems.Position
        switch indexPath.row {
        case 0:
            position = .first
        case viewModel.categories.count - 1:
            position = .last
        default:
            position = .middle
        }
        categoryCell.configure(with: category.label,
                               isSelected: isSelected,
                               position: position)
        
        return categoryCell
    }
}

// MARK: - UITableViewDelegate

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ListOfItems.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCategory(at: indexPath)
    }
}

// MARK: - CategoriesViewModelDelegate

extension CategoriesViewController: CategoriesViewModelDelegate {
    func didUpdateCategories() {
        if viewModel.categories.isEmpty {
            starCombined.isHidden = false
        } else {
            starCombined.isHidden = true
        }
        categoriesView.reloadData()
    }
    
    func didSelectCategory(_ category: TrackerCategory) {
        delegate?.didConfirm(category)
    }
    
    func tableView(
        _ tableView: UITableView,
        contextMenuConfigurationForRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        let category = viewModel.categories[indexPath.row]
        
        return UIContextMenuConfiguration(actionProvider:  { _ in
            UIMenu(children: [
                UIAction(title: NSLocalizedString("SetCategoriesViewController.edit", comment: "Edit")) { [weak self] _ in
                    self?.editCategory(category)
                },
                UIAction(title: NSLocalizedString("SetCategoriesViewController.delete", comment: "Delete"), attributes: .destructive) { [weak self] _ in
                    self?.deleteCategory(category)
                }
            ])
        })
    }
}

extension CategoriesViewController: CategoryFormViewControllerDelegate {
    func didConfirm(_ data: TrackerCategory.Data) {
        viewModel.handleCategoryFormConfirm(data: data)
        dismiss(animated: true)
    }
}
