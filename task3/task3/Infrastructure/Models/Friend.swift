//
// Created by Alexey Sidorov on 2019-03-21.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import RealmSwift

public class Friend: Object {
    @objc dynamic var ID: Int = 0

    convenience init(ID: Int) {
        self.init()

        self.ID = ID
    }
}