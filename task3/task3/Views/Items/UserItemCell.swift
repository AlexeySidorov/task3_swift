//
//  UserItemCell.swift
//  task3
//
//  Created by Alexey Sidorov on 22/03/2019.
//  Copyright © 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import UIKit

class UserItemCell: UITableViewCell {
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var statusImgView: UIView = UIView()
    var item: UserResponse!
    
    func setData(value: UserResponse) {
        userName.text = value.name
        email.text = value.email
        item = value
    }
}

