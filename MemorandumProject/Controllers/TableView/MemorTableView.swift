//
//  MemorTableView.swift
//  MemorandumProject
//
//  Created by Aleksandr  on 26.01.2023.
//

import UIKit
import CoreData

class MainTableView: UIView {
    
    var task: [Tasks] = []
    
    private var mytableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.layer.cornerRadius = 21
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delaysContentTouches = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var memors = [MemorandumProtocol]()
    private let idTableViewCell = "idTableViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setDelegates()
        setConstraint()
    }
    
    private func setupViews() {
        
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(mytableView)
        mytableView.register(TableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDelegates() {
        mytableView.delegate = self
        mytableView.dataSource = self
    }
}
// MARK: - UITableViewDataSource

extension MainTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

//MARK: - UITableViewDelegate

extension MainTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

//MARK: - Set Constraints

extension MainTableView {
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            mytableView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            mytableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mytableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mytableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}


