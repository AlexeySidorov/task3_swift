//
// Created by Alexey Sidorov on 2019-03-21.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation

class UserUtility {
    static let Instance = UserUtility()

    func convertUsersResponseToUsers(users: [UserResponse]) -> [User] {
        var arrayUsers = [User]()

        for user in users {
            arrayUsers.append(convertUserResponseToUser(user: user))
        }

        return arrayUsers
    }

    func convertUserResponseToUser(user: UserResponse) -> User {
        return User(ID: user.ID, guid: user.guid, gender: user.gender, isActive: user.isActive, latitude: user.latitude,
                longitude: user.longitude, name: user.name, phone: user.phone, address: user.address, age: user.age,
                registered: user.registered as NSDate, balance: user.balance, company: user.company, email: user.email,
                about: user.about, eyeColor: user.eyeColor, favoriteFruit: user.favoriteFruit, tags: user.tags,
                friends: FriendUtility.Instance.convertFriendsResponseToFriends(users: user.friends))
    }

    func convertUsersToUsersResponse(users: [User]) -> [UserResponse] {
        var arrayUsers = [UserResponse]()

        for user in users {
            arrayUsers.append(convertUserToUserResponse(user: user))
        }

        return arrayUsers
    }

    func convertUserToUserResponse(user: User) -> UserResponse {
        return UserResponse(ID: user.ID, guid: user.guid, gender: user.gender, isActive: user.isActive, latitude: user.latitude,
                longitude: user.longitude, name: user.name, phone: user.phone, address: user.address, age: user.age, registered:
                user.registered as Date, balance: user.balance, company: user.company, email: user.email, about: user.about,
                eyeColor: EyeColor.init(rawValue: user.eyeColor) ?? EyeColor.None,
                favoriteFruit: FavoriteFruit.init(rawValue: user.favoriteFruit) ?? FavoriteFruit.None, tags: [String](user.tags),
                friends: FriendUtility.Instance.convertFriendsToFriendsResponse(users: [Friend](user.friends)))
    }
}
