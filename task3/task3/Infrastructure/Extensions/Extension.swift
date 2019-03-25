//
// Created by Alexey Sidorov on 2019-03-24.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func date(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.date(from: self)
        return date
    }
}

extension Date {
    func convert(format: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone.current
        let date = dateFormatter.string(from: self)
        return date
    }
}