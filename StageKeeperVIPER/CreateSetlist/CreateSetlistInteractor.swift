//
//  CreateSetlistInteractor.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 30/04/2024.
//

import Foundation

protocol CreateSetlistInteractorProtocol {
    var presenter: CreateSetlistPresenterProtocol? { get set }
}

class CreateSetlistInteractor: CreateSetlistInteractorProtocol {
    var presenter: CreateSetlistPresenterProtocol?
}
