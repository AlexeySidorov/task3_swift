//
//  FriendResponse.swift
//  task3
//
//  Created by Alexey Sidorov on 21/03/2019.
//  Copyright © 2019 Alexey Sidorov. All rights reserved.
//

import Foundation

public struct FriendResponse: Codable {
    public var ID: Int

    init(ID: Int) {
        self.ID = ID
    }

    enum CodingKeys: String, CodingKey {
        case ID = "id"
    }
}
