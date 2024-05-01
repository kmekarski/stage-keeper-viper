//
//  CreateSetlistView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation
import UIKit

protocol CreateSetlistViewProtocol {
    var presenter: CreateSetlistPresenterProtocol? { get set }
}

class CreateSetlistViewController: UIViewController, CreateSetlistViewProtocol {
    var presenter: CreateSetlistPresenterProtocol?
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create setlist"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
}

private extension CreateSetlistViewController {
    func configureUI() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
