//
// Created by Alexey Sidorov on 2019-03-21.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation

class FriendUtility {
    static let Instance = FriendUtility()

    func convertFriendsResponseToFriends(users: [FriendResponse]) -> [Friend] {
        var arrayUsers = [Friend]()

        for user in users {
            arrayUsers.append(convertFriendResponseToFriend(user: user))
        }

        return arrayUsers
    }

    func convertFriendResponseToFriend(user: FriendResponse) -> Friend {
        return Friend(ID: user.ID)
    }

    func convertFriendsToFriendsResponse(users: [Friend]) -> [FriendResponse] {
        var arrayUsers = [FriendResponse]()

        for user in users {
            arrayUsers.append(convertFriendToFriendResponse(user: user))
        }

        return arrayUsers
    }

    func convertFriendToFriendResponse(user: Friend) -> FriendResponse {
        return FriendResponse(ID: user.ID)
    }
}
