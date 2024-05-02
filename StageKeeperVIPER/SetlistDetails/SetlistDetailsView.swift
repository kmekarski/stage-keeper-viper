//
//  SetlistDetailsView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation
import UIKit

protocol SetlistDetailsViewProtocol {
    var presenter: SetlistDetailsPresenterProtocol? { get set }
    
    func updateSetlist(with setlist: Setlist)
    func updateSetlistError(with errorMessage:String)
}

class SetlistDetailsViewController: UIViewController, SetlistDetailsViewProtocol {
    var presenter: (any SetlistDetailsPresenterProtocol)?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteSetlist), for: .touchUpInside)
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    func updateSetlist(with setlist: Setlist) {
        self.nameLabel.text = setlist.name
    }
    
    func updateSetlistError(with errorMessage: String) {
        self.errorLabel.text = errorMessage
        self.errorLabel.isHidden = false
    }
}

private extension SetlistDetailsViewController {
    var padding: CGFloat {
        return 24
    }
    
    func configureUI() {
        view.addSubview(nameLabel)
        view.addSubview(errorLabel)
        view.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            deleteButton.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 48),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            deleteButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc
    func deleteSetlist() {
        presenter?.deleteSetlist()
    }
}
