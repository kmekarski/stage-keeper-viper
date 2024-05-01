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
    func configureUI() {
        view.addSubview(nameLabel)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
