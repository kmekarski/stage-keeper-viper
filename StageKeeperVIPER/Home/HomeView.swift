//
//  SetlistsListView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation
import UIKit

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func updateSetlists(with setlists: [Setlist])
    func updateSongs(with songs: [Song])
    func updateSetlistsError(with errorMessage: String)
    func updateSongsError(with errorMessage: String)
}

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: HomePresenterProtocol?
    
    var setlists: [Setlist] = []
    var songs: [Song] = []
    
    private let setlistsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SetlistCell")
        table.isHidden = true
        return table
    }()
    
    private let songsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SongCell")
        table.isHidden = true
        return table
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setlistsTable.delegate = self
        setlistsTable.dataSource = self
        songsTable.delegate = self
        songsTable.dataSource = self
        configureUI()
    }
    
    func updateSetlists(with setlists: [Setlist]) {
        DispatchQueue.main.async {
            self.setlists = setlists
            self.setlistsTable.reloadData()
            self.setlistsTable.isHidden = false
        }
    }
    
    func updateSongs(with songs: [Song]) {
        DispatchQueue.main.async {
            self.songs = songs
            self.songsTable.reloadData()
            self.songsTable.isHidden = false
        }
    }
    
    func updateSetlistsError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.setlists = []
            self.setlistsTable.isHidden = true
            self.errorLabel.text = errorMessage
            self.errorLabel.isHidden = false

        }
    }
    
    func updateSongsError(with errorMessage: String) {
        DispatchQueue.main.async {
            self.songs = []
            self.songsTable.isHidden = true
            self.errorLabel.text = errorMessage
            self.errorLabel.isHidden = false

        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = setlistsTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = setlists[indexPath.row].name
        cell.contentConfiguration = config
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.setlistTapped(setlist: setlists[indexPath.row])
    }
}

private extension HomeViewController {
    func configureUI() {
        let padding: CGFloat = 24
        
        view.backgroundColor = .systemMint
        view.addSubview(setlistsTable)
        view.addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            setlistsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setlistsTable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            setlistsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            setlistsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            setlistsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            setlistsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
