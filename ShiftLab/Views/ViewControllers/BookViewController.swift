//
//  ContestViewController.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import UIKit

class BookViewController: UIViewController {

    // MARK: - Properties

    private let viewModel = BooksViewModel()
    private let uiComponentFactory = UIComponentFactory.shared
    private let userDataStore: UserDataStoreProtocol = UserDataStore()

    // MARK: - UI Elements

    private lazy var greetingsButton = uiComponentFactory.makeButton(
        withTitle: "Приветствие",
        target: self,
        action: #selector(greetingsAction)
    )
    private lazy var booksTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }

    // MARK: - UI Setup

    func setupUI() {
        view.backgroundColor = .white

        view.addSubview(greetingsButton)
        view.addSubview(booksTableView)

        NSLayoutConstraint.activate([
            booksTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            booksTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            booksTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            booksTableView.heightAnchor.constraint(equalToConstant: 600),

            greetingsButton.topAnchor.constraint(equalTo: booksTableView.bottomAnchor, constant: 50),
            greetingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingsButton.widthAnchor.constraint(equalToConstant: 250),
            greetingsButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Table View Configuration

    func configureTableView() {
        booksTableView.dataSource = self
        booksTableView.delegate = self
        booksTableView.register(
            BookTableViewCell.self,
            forCellReuseIdentifier: BookTableViewCell.reuseIdentifier
        )
        booksTableView.separatorStyle = .singleLine
        booksTableView.rowHeight = UITableView.automaticDimension
        booksTableView.estimatedRowHeight = 100
        
        booksTableView.layer.borderWidth = 3.0
        booksTableView.layer.borderColor = UIColor.black.cgColor
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        booksTableView.refreshControl = refreshControl
    }

    // MARK: - Data Fetching

    private func setupViewModel() {
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.booksTableView.reloadData()
            }
        }
    }

    // MARK: - Button Action

    @objc func greetingsAction() {
        if let user = userDataStore.loadUserData(), let userName = user.name {
            let alertController = uiComponentFactory.makeAlert(
                title: "Привет!",
                message: "\(userName)"
            )
            present(alertController, animated: true, completion: nil)
        } else {
            let alertController = uiComponentFactory.makeAlert(
                title: "Упс...",
                message: "Данные пользователя не найдены."
            )
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //MARK: - Reload TableView
    @objc private func refreshData() {
        viewModel.getData()
        booksTableView.refreshControl?.endRefreshing()
    }

}

extension BookViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getBooksCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = booksTableView.dequeueReusableCell(
            withIdentifier: BookTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! BookTableViewCell
        let book = viewModel.getBook(at: indexPath.row)
        cell.configure(with: book)
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedBook = viewModel.getBook(at: indexPath.row)
        
        guard let url = URL(string: selectedBook.image) else { return }
        
        let imageViewController = ImageViewController()
        imageViewController.imageURL = url
        
        present(imageViewController, animated: true)
    }
}

