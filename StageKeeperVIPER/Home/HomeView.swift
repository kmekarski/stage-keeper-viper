//
//  SetlistsListView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 29/04/2024.
//

import Foundation
import UIKit

enum HomeTableType {
    case setlists
    case songs
}

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func updateSetlists(with setlists: [Setlist])
    func updateSongs(with songs: [Song])
    func didCreateSetlist(setlist: Setlist)
    func didCreateSong(song: Song)
    func updateSetlistsError(with errorMessage: String)
    func updateSongsError(with errorMessage: String)
}

class HomeViewController: UIViewController, HomeViewProtocol {
    
    var presenter: HomePresenterProtocol?
    
    var setlists: [Setlist] = []
    var songs: [Song] = []
    var activeTable: HomeTableType = .setlists
    
    private let setlistsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "SetlistCell")
        table.isHidden = false
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
    
    private lazy var switchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(switchTables), for: .touchUpInside)
        button.setTitle("Switch", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToCreate), for: .touchUpInside)
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .blue
        return button
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
        }
    }
    
    func updateSongs(with songs: [Song]) {
        DispatchQueue.main.async {
            self.songs = songs
            self.songsTable.reloadData()
        }
    }
    
    func didCreateSetlist(setlist: Setlist) {
        setlists.append(setlist)
        setlistsTable.reloadData()
    }
    
    func didCreateSong(song: Song) {
        songs.append(song)
        songsTable.reloadData()
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
        if tableView == setlistsTable {
            return setlists.count
        } else {
            return songs.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == setlistsTable {
            let cell = setlistsTable.dequeueReusableCell(withIdentifier: "SetlistCell", for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = setlists[indexPath.row].name
            cell.contentConfiguration = config
            return cell
        } else {
            let cell = songsTable.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)
            var config = cell.defaultContentConfiguration()
            config.text = songs[indexPath.row].name
            cell.contentConfiguration = config
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == setlistsTable {
            presenter?.setlistTapped(setlist: setlists[indexPath.row])
        } else {
            presenter?.songTapped(song: songs[indexPath.row])
        }
    }
}

private extension HomeViewController {
    func configureUI() {
        let padding: CGFloat = 24
        
        view.backgroundColor = .systemMint
        view.addSubview(setlistsTable)
        view.addSubview(songsTable)
        view.addSubview(errorLabel)
        view.addSubview(switchButton)
        view.addSubview(createButton)
                
        NSLayoutConstraint.activate([
            setlistsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            setlistsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            setlistsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            setlistsTable.heightAnchor.constraint(equalToConstant: 400),
            
            songsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            songsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            songsTable.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            songsTable.heightAnchor.constraint(equalToConstant: 400),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            switchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            switchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            switchButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            switchButton.heightAnchor.constraint(equalToConstant: 48),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createButton.bottomAnchor.constraint(equalTo: switchButton.topAnchor, constant: -48),
            createButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc
    func switchTables() {
        if activeTable == .setlists {
            activeTable = .songs
            songsTable.isHidden = false
            setlistsTable.isHidden = true
        } else {
            activeTable = .setlists
            songsTable.isHidden = true
            setlistsTable.isHidden = false
        }
    }
    
    @objc
    func goToCreate() {
        switch activeTable {
        case .songs:
            presenter?.createSongTapped()
        case .setlists:
            presenter?.createSetlistTapped()
        }
    }
}

#Preview {
    HomeViewController()
}
