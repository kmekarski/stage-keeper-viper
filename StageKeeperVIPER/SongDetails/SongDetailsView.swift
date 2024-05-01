//
//  SongDetailsView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation
import UIKit

protocol SongDetailsViewProtocol {
    var presenter: SongDetailsPresenterProtocol? { get set }
    
    func updateSong(with song: Song)
    func updateSongError(with errorMessage:String)
}

class SongDetailsViewController: UIViewController, SongDetailsViewProtocol {
    var presenter: SongDetailsPresenterProtocol?
    
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
    
    func updateSong(with song: Song) {
        self.nameLabel.text = song.name
    }
    
    func updateSongError(with errorMessage: String) {
        self.errorLabel.text = errorMessage
        self.errorLabel.isHidden = false
    }
}

private extension SongDetailsViewController {
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
