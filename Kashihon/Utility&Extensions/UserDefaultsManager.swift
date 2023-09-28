//
//  UserDefaultsManager.swift
//  Kashihon
//
//  Created by t&a on 2023/09/28.
//

import UIKit

import UIKit

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard

    public func setMigration() {
        userDefaults.set(MigrationInfo.MIGRATION_VERSION, forKey: "migration_version")
    }

    public func getMigration() -> Int {
        userDefaults.integer(forKey: "migration_version")
    }
}
