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
    var song: Song?
    
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
        button.addTarget(self, action: #selector(deleteSong), for: .touchUpInside)
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    func updateSong(with song: Song) {
        self.song = song
        nameLabel.text = song.name
    }
    
    func updateSongError(with errorMessage: String) {
        errorLabel.text = errorMessage
        errorLabel.isHidden = false
    }
}

private extension SongDetailsViewController {
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
    func deleteSong() {
        presenter?.deleteSong()
    }
}

#Preview {
    let song = mockSongs.first!
    let songDetailsRouter = SongDetailsRouter.createSongDetails(with: song)
    let songDetailsVC = songDetailsRouter.entry!
    return songDetailsVC
}
