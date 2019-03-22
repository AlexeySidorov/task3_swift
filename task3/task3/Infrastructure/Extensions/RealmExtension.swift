//
// Created by Alexey Sidorov on 2019-03-22.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import RealmSwift

extension Results{
    func toArray() -> [Element] {
        return self.map{$0}
    }
}

extension List {
    func toArray() -> [Element] {
        return self.map{$0}
    }
}
