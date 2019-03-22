//
// Created by Alexey Sidorov on 11/12/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import RealmSwift

class ConfigurationRealmHelper {
    static let Instance = ConfigurationRealmHelper()

    let configuration: Realm.Configuration = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                switch oldSchemaVersion {
                case 1:
                    break
                default:
                    break
                }
            })
}
