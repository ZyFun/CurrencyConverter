//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Дмитрий Данилин on 23.08.2022.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    static let identifier = String(describing: CurrencyCell.self)
    
    // MARK: - Private properties
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let charCodeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nominalLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(nameLabel)
        addSubview(charCodeLabel)
        addSubview(valueLabel)
        addSubview(nominalLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            charCodeLabel.topAnchor.constraint(greaterThanOrEqualTo: nameLabel.bottomAnchor, constant: 5),
            charCodeLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: charCodeLabel.topAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            nominalLabel.centerYAnchor.constraint(equalTo: valueLabel.centerYAnchor),
            nominalLabel.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor, constant: -3)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = ""
        charCodeLabel.text = ""
        valueLabel.text = ""
        nominalLabel.text = ""
        nameLabel.textColor = .label
    }
}

// MARK: - Public methods

extension CurrencyCell {
    func config(
        charCode: String?,
        nominal: String?,
        name: String?,
        value: String?,
        isFavorite: Bool
    ) {
        charCodeLabel.text = charCode
        nameLabel.text = name
        valueLabel.text = (value ?? "0.0") + " ₽"
        nominalLabel.text = (nominal ?? "nil") + " = "
        
        if isFavorite {
            nameLabel.textColor = .orange
        }
    }
}
