//
//  ContestViewController.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 10.12.2023.
//

import UIKit

class NewsViewController: UIViewController {

    // MARK: - Properties

    private let viewModel = NewsViewModel()
    private let uiComponentFactory = UIComponentFactory.shared
    private let userDataStore: UserDataStoreProtocol = UserDataStore()
    private var articles: [Article] = []

    // MARK: - UI Elements

    private lazy var greetingsButton = uiComponentFactory.makeButton(
        withTitle: "Приветствие",
        target: self,
        action: #selector(greetingsAction)
    )
    private lazy var newsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        getData()
    }

    // MARK: - UI Setup

    func setupUI() {
        view.backgroundColor = .red

        view.addSubview(greetingsButton)
        view.addSubview(newsTableView)

        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.heightAnchor.constraint(equalToConstant: 500),

            greetingsButton.topAnchor.constraint(equalTo: newsTableView.bottomAnchor, constant: 50),
            greetingsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greetingsButton.widthAnchor.constraint(equalToConstant: 250),
            greetingsButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    // MARK: - Table View Configuration

    func configureTableView() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        newsTableView.register(
            ArticleTableViewCell.self,
            forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier
        )
        newsTableView.separatorStyle = .none
        newsTableView.rowHeight = UITableView.automaticDimension
        newsTableView.estimatedRowHeight = 100
    }

    // MARK: - Data Fetching

    func getData() {
        viewModel.getData { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self?.articles = self?.viewModel.articles ?? []
                    self?.newsTableView.reloadData()
                }

            case .failure(let error):
                print("Failed to fetch data: \(error)")
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

}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(
            withIdentifier: ArticleTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.configure(with: article)
        return cell
    }

    // MARK: - UITableViewDelegate

}

