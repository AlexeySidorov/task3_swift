//
// Created by Alexey Sidorov on 2019-03-21.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation

public struct UserResponse: Codable {
    public var ID: Int = 0
    public var guid: String = ""
    public var gender: String = ""
    public var isActive: Bool = false
    public var latitude: Double = 0
    public var longitude: Double = 0
    public var name: String = ""
    public var phone: String = ""
    public var address: String = ""
    public var age: Int = 0
    public var registered: Date
    public var balance: String = ""
    public var company: String = ""
    public var email: String = ""
    public var about: String = ""
    public var eyeColor: EyeColor = .None
    public var favoriteFruit: FavoriteFruit = .None
    public var tags: [String] = [String]()
    public var friends: [FriendResponse] = [FriendResponse]()

    init(ID: Int, guid: String, gender: String, isActive: Bool, latitude: Double, longitude: Double, name: String,
         phone: String, address: String, age: Int, registered: Date, balance: String, company: String, email: String,
         about: String, eyeColor: EyeColor, favoriteFruit: FavoriteFruit, tags: [String], friends: [FriendResponse]) {

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
        self.eyeColor = eyeColor
        self.favoriteFruit = favoriteFruit
        self.tags = tags
        self.friends = friends
    }

    enum CodingKeys: String, CodingKey {
        case ID = "id"
        case guid = "guid"
        case gender = "gender"
        case isActive = "isActive"
        case latitude = "latitude"
        case longitude = "longitude"
        case name = "name"
        case phone = "phone"
        case address = "address"
        case age = "age"
        case registered = "registered"
        case balance = "balance"
        case company = "company"
        case email = "email"
        case about = "about"
        case eyeColor = "eyeColor"
        case favoriteFruit = "favoriteFruit"
        case tags = "tags"
        case friends = "friends"
    }
}
