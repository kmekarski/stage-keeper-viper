//
//  CreateSongView.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation
import UIKit

enum CreateSongScreen {
    case first
    case second
}

protocol CreateSongViewProtocol {
    var presenter: CreateSongPresenterProtocol? { get set }
    func getSongData() -> Song?
    func displayError(_ error: CreateSongError)
}

class CreateSongViewController: UIViewController, CreateSongViewProtocol {
    
    var presenter: CreateSongPresenterProtocol?
    var screen: CreateSongScreen
    var song: Song?
    
    private let createSongLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create song"
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Name"
        return field
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createSongButtonPressed), for: .touchUpInside)
        button.setTitle("Create", for: .normal)
        button.backgroundColor = .blue
        button.isHidden = true
        return button
    }()
    
    init(screen: CreateSongScreen, song: Song? = nil) {
        self.screen = screen
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    func getSongData() -> Song? {
        guard let name = nameTextField.text else { return nil }
        return Song(name: name)
    }
    
    func displayError(_ error: CreateSongError) {
        switch error {
        case .emptySongName:
            print("song name should not be empty")
        case .invalidSongData:
            print("something went wrong")
        }
    }
}

private extension CreateSongViewController {
    var padding: CGFloat {
        return 24
    }
    func configureUI() {
        view.addSubview(createSongLabel)
        
        NSLayoutConstraint.activate([
            createSongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createSongLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
        
        switch screen {
        case .first:
            configureFirstScreen()
        case .second:
            configureSecondScreen()
        }
    }
    
    func configureFirstScreen() {
        view.addSubview(nameTextField)
        view.addSubview(nextButton)
        
        nextButton.isHidden = false
        createButton.isHidden = true
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: createSongLabel.bottomAnchor, constant: 48),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            nextButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 48),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nextButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    func configureSecondScreen() {
        view.addSubview(createButton)
        view.addSubview(nameLabel)
        
        nextButton.isHidden = true
        createButton.isHidden = false
        
        nameLabel.text = song?.name ?? ""
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: createSongLabel.bottomAnchor, constant: 48),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 48),
            
            createButton.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 48),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            createButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    @objc
    func nextButtonPressed() {
        presenter?.goToSecondScreen()
    }
    
    @objc
    func createSongButtonPressed() {
        presenter?.createSong()
    }
}

#Preview {
    CreateSongViewController(screen: .first)
}
