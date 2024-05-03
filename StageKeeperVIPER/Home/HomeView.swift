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
    func didDeleteSetlist(setlist: Setlist)
    func didDeleteSong(song: Song)
    func updateSetlistsError()
    func updateSongsError()
    func displaySignOutError()
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
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        button.setTitle("Sign out", for: .normal)
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
    
    func didDeleteSetlist(setlist: Setlist) {
        setlists.removeAll { el in
            el.name == setlist.name
        }
        setlistsTable.reloadData()
    }
    
    func didDeleteSong(song: Song) {
        songs.removeAll { el in
            el.name == song.name
        }
        songsTable.reloadData()
    }
    
    func updateSetlistsError() {
        DispatchQueue.main.async {
            self.setlists = []
            self.setlistsTable.isHidden = true
            self.errorLabel.text = "Unable to fetch setlists"
            self.errorLabel.isHidden = false
        }
    }
    
    func updateSongsError() {
        DispatchQueue.main.async {
            self.songs = []
            self.songsTable.isHidden = true
            self.errorLabel.text = "Unable to fetch songs"
            self.errorLabel.isHidden = false
        }
    }
    
    func displaySignOutError() {
        print("Unable to sign out")
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
        view.addSubview(signOutButton)
                
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
            
            signOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            signOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            signOutButton.heightAnchor.constraint(equalToConstant: 48),
            
            switchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            switchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            switchButton.bottomAnchor.constraint(equalTo: signOutButton.topAnchor, constant: -24),
            switchButton.heightAnchor.constraint(equalToConstant: 48),
            
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createButton.bottomAnchor.constraint(equalTo: switchButton.topAnchor, constant: -24),
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
    func createButtonTapped() {
        switch activeTable {
        case .songs:
            presenter?.createSongTapped()
        case .setlists:
            presenter?.createSetlistTapped()
        }
    }
    
    @objc
    func signOutButtonTapped() {
        presenter?.signOut()
    }
}

#Preview {
    let homeRouter = HomeRouter.start()
    let homeVC = homeRouter.entry!
    let navigation = UINavigationController()
    navigation.viewControllers = [homeVC]
    return navigation
}
