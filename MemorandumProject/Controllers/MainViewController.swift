//
//  MainViewController.swift
//  MemorandumProject
//
///  Created by Aleksandr  on 25.01.2023.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    var task: [Tasks] = []
    
    private var memorLabel = UILabel()
    private var addButton = actionButton(text: "Добавить")
    private var delButton = UIButton()
    private var fotoMemorButton = actionButton(text: "Фото заметка")
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .none
        tableView.separatorStyle = .singleLine
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        do {
            task = try context.fetch(fetchRequest)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
    }
    
    private func setupViews() {
        
        view.backgroundColor = .white
        
        addButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        view.addSubview(addButton)
              
        memorLabel = UILabel(frame: CGRect(x: 40, y: 80, width: 100, height: 70))
        memorLabel.text = "Заметки"
        memorLabel.textColor = .systemBlue
        view.addSubview(memorLabel)
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(fotoMemorButton)
       fotoMemorButton.addTarget(self, action: #selector(buttonImageTapped), for: .touchUpInside)
        
        delButton = UIButton(type: .system)
        delButton.frame = CGRect(x: 90, y: 770, width: 200, height: 50)
        delButton.setTitle("Удалить заметки", for: .normal)
        delButton.tintColor = .red
        delButton.backgroundColor = .none
        delButton.layer.cornerRadius = 8
        delButton.addTarget(self, action: #selector(buttonIsDelTapped), for: .touchUpInside)
        view.addSubview(delButton)
    }
    
    private func setDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func buttonIsTapped(sender: UIButton) {
        
        let alertController = UIAlertController(title: "Новая заметка", message: "Введите текст", preferredStyle: .alert)
        
        let saveTask = UIAlertAction(title: "Сохранить", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTask = tf?.text {
                self.saveTask(withTitle: newTask)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        
        let canselAction = UIAlertAction(title: "Отмена", style: .default)
        
        alertController.addAction(saveTask)
        alertController.addAction(canselAction)
        
        present(alertController, animated: true)
    }
    
    func saveTask(withTitle title: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context) else { return }
        
        let taskObject = Tasks(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            task.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    @objc func buttonImageTapped(sender: UIButton) {
        let newMemorViewController = MemorandumFotoController()
        newMemorViewController.modalPresentationStyle = .fullScreen
         present(newMemorViewController, animated: true)
    }
    
    @objc func buttonIsDelTapped(sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        
        if let task = try? context.fetch(fetchRequest) {
            for tasks in task {
                context.delete(tasks)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
}
// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let task = task[indexPath.row]
        cell.textLabel?.text = task.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        56
    }
}
//MARK: - Set Constraints

extension MainViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 80),
            
            fotoMemorButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            fotoMemorButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            fotoMemorButton.widthAnchor.constraint(equalToConstant: 120),
            
            tableView.topAnchor.constraint(equalTo: fotoMemorButton.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
}
