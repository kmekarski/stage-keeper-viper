//
//  CreateSetlistRouterDelegate.swift
//  StageKeeperVIPER
//
//  Created by Klaudiusz Mękarski on 02/05/2024.
//

import Foundation

protocol CreateSetlistRouterDelegate: AnyObject {
    func didCreateSetlist(setlist: Setlist)
}
