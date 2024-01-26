//
//  HomeViewController.swift
//  HowsTheWear
//
//  Created by Rafael on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {

    private let customBarButtonItem = CustomBarButtonItem()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let backgroundImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBarUI()
        configureAddTargets()
        configureUI()
    }

}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrentWeatherCell.identifier, for: indexPath) as? CurrentWeatherCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

extension HomeViewController: UITableViewDelegate {
}


// MARK: - Navigation Bar Setup

private extension HomeViewController {
    
    func configureNavBarUI() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = appearance
        
        setupNavigationBarButton()
    }
    
    func setupNavigationBarButton() {
        let rightButton = UIBarButtonItem(customView: customBarButtonItem.locationButton)
        navigationItem.rightBarButtonItem = rightButton
    }
    
}

// MARK: - UI Setup

private extension HomeViewController {
    
    func configureUI() {
        setupBackgroundImageView()
        setupTableView()
    }
    
    func setupBackgroundImageView() {
        backgroundImageView.image = UIImage(named: "background-image")
        backgroundImageView.contentMode = .scaleAspectFill
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        tableView.separatorStyle = .none
        tableView.backgroundView = backgroundImageView
        tableView.dataSource = self
        tableView.delegate = self
        
        registerTableViewCells()
    }
    
    func registerTableViewCells() {
        let cellTypes = [CurrentWeatherCell.self]
        
        cellTypes.forEach { cellType in
            tableView.register(cellType, forCellReuseIdentifier: cellType.identifier)
        }
    }
    
}

// MARK: - Button Target Configuration

private extension HomeViewController {
    
    func configureAddTargets() {
        customBarButtonItem.locationButton.addTarget(
            self,
            action: #selector(locationButtonDidTap),
            for: .touchUpInside
        )
    }
    
}

// MARK: - Button Action Method

private extension HomeViewController {
    
    @objc func locationButtonDidTap() {
        print("Clicked")
    }
    
}
