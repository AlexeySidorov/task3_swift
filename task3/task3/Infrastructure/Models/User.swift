//
// Created by Alexey Sidorov on 2019-03-21.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import RealmSwift

public class User: Object {

    @objc dynamic var ID: Int = 0
    @objc dynamic var guid: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var isActive: Bool = false
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    @objc dynamic var name: String = ""
    @objc dynamic var phone: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var registered: NSDate = NSDate()
    @objc dynamic var balance: String = ""
    @objc dynamic var company: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var about: String = ""
    @objc dynamic var eyeColor: String = ""
    @objc dynamic var favoriteFruit: String = ""
    var tags: List<String> = List<String>()
    var friends: List<Friend> = List<Friend>()

    override public static func primaryKey() -> String? {
        return "ID"
    }

    convenience init(ID: Int, guid: String, gender: String, isActive: Bool, latitude: Double, longitude: Double, name: String,
                     phone: String, address: String, age: Int, registered: NSDate, balance: String, company: String, email: String,
                     about: String, eyeColor: EyeColor, favoriteFruit: FavoriteFruit, tags: [String], friends: [Friend]) {
        self.init()

        self.ID = ID
        self.guid = guid
        self.gender = gender
        self.isActive = isActive
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.phone = phone
        self.address = address
        self.age = age
        self.registered = registered
        self.balance = balance
        self.company = company
        self.email = email
        self.about = about
        self.eyeColor = eyeColor.toString()
        self.favoriteFruit = favoriteFruit.toString()
        self.tags.append(objectsIn: tags)
        self.friends.append(objectsIn: friends)
    }

    func incrementID() -> Int {
        let realm = try! Realm(configuration: ConfigurationRealmHelper.Instance.configuration)
        return (realm.objects(User.self).max(ofProperty: "ID") as Int? ?? 0) + 1
    }
}
