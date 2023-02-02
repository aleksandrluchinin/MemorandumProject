//
//  MemorTableViewCell.swift
//  MemorandumProject
//
//  Created by Aleksandr  on 26.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    private let backgroundCell: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 21
        view.backgroundColor = .systemGray4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let oneBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let rabbitImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit//формат отабражения
        imageView.image = UIImage(named: "rabbit")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите текст"
        label.textColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var memorTextField: UITextField = {
        let textFild = UITextField()
        textFild.backgroundColor = .systemGray2
        textFild.borderStyle = .none
        textFild.layer.cornerRadius = 10
        textFild.textColor = .brown
        textFild.leftView = UIView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: 120,
                                                  height: 20))
        textFild.leftViewMode = .always
        textFild.clearButtonMode = .always
        textFild.returnKeyType = .done
        textFild.translatesAutoresizingMaskIntoConstraints = false
        return textFild
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(backgroundCell)
        addSubview(oneBackgroundView)
        addSubview(nameLabel)
        addSubview(memorTextField)
        addSubview(rabbitImageView)
    }
}

extension TableViewCell {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backgroundCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            backgroundCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
            backgroundCell.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            
            oneBackgroundView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            oneBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            oneBackgroundView.heightAnchor.constraint(equalToConstant: 77),
            oneBackgroundView.widthAnchor.constraint(equalToConstant: 77),
            
            rabbitImageView.centerXAnchor.constraint(equalTo: oneBackgroundView.centerXAnchor),
            rabbitImageView.centerYAnchor.constraint(equalTo: oneBackgroundView.centerYAnchor),
            rabbitImageView.heightAnchor.constraint(equalToConstant: 70),
            rabbitImageView.widthAnchor.constraint(equalToConstant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: rabbitImageView.leadingAnchor, constant: 100),
            
            memorTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            memorTextField.leadingAnchor.constraint(equalTo: rabbitImageView.leadingAnchor, constant: 100),
            memorTextField.widthAnchor.constraint(equalToConstant: 200),
            memorTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}


