//
// Created by Alexey Sidorov on 06/12/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import RealmSwift

protocol UserService {
    func clearDataBase()
    func addOrUpdateUsers(users: [User])
    func getUsers() -> [User]
    func getFriends(friends: [Friend]) -> [User]
    func getIsUsers() -> Bool
}

class UserRepository: UserService {
    let realm = try! Realm(configuration: ConfigurationRealmHelper.Instance.configuration)

    func getUsers() -> [User] {
        let users = realm.objects(User.self);
        return users.toArray()
    }

    func getFriends(friends: [Friend]) -> [User] {
        let result = realm.objects(User.self)

        var array = Array<Int>()
        for friend in friends {
            array.append(friend.ID)
        }

        let users = result.filter("ID IN %@", array)
            return users.toArray()
    }

    func clearDataBase() {
        try! realm.write {
            realm.deleteAll()
        }
    }

    func addOrUpdateUsers(users: [User]) {
        for user in users {
            let usr = realm.object(ofType: User.self, forPrimaryKey: user.ID)

            try! realm.write {
                realm.add(user, update: usr != nil)
            }
        }
    }

    func getIsUsers() -> Bool {
        let result = realm.objects(User.self)
        return result.count != 0
    }
}
