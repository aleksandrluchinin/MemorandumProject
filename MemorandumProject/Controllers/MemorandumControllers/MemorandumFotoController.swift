//
//  MemorandumFotoController.swift
//  MemorandumProject
//
//  Created by Aleksandr  on 26.01.2023.
//

import UIKit

class MemorandumFotoController: UIViewController {

    var userDefaults = UserDefaults.standard
    
    @objc private var dismisButtonButton = actionButton(text: "Вернуться")
    
    private var newMemors: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .none
        button.setTitle("Создать заметку", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .systemPurple
        button.addTarget(self, action: #selector(addButtonTaped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView = MainTableView()
    
      override func viewDidLoad() {
          super.viewDidLoad()
          
          print( userDefaults.object(forKey: "Some key") )
          print( userDefaults.string(forKey: "Some key") )
          
          setupViews()
          setConstraint()
      }
      
      private func setupViews() {
          
          view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          view.addSubview(newMemors)
          view.addSubview(tableView)
          view.addSubview(dismisButtonButton)
          dismisButtonButton.addTarget(self, action: #selector(dismisButtonTaped), for: .touchUpInside)
      }
    
    @objc private func addButtonTaped() {
        alertMemor(title: "Создать новую запись", placeholder: "Введите текст") { (text) in
            print(text)
        }
    }
    
    @objc private func dismisButtonTaped() {
        self.dismiss(animated: true, completion: nil)
    }
}

  extension MemorandumFotoController {
      
      private func setConstraint() {
          NSLayoutConstraint.activate([
            newMemors.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,  constant: 20),
            newMemors.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            
              tableView.topAnchor.constraint(equalTo: newMemors.bottomAnchor, constant: 10),
              tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
              tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
              tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            dismisButtonButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            dismisButtonButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
          ])
      }
  }



