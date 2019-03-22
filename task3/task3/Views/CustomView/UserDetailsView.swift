//
// Created by Alexey Sidorov on 2019-03-22.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import UIKit

func setDetailsView(cellHeigth: CGFloat, item: UserResponse) -> UIView {
    let viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: cellHeigth))
    let status = UIImageView(image: UIImage(named: item.isActive ? "ActiveUser" : "NotActiveUser"))
    let arrow = UIImageView(image: UIImage(named: "DisclosureIndicator"))
    status.frame = CGRect(x: 0, y: 8, width: 24, height: 24)
    arrow.frame = CGRect(x: status.frame.origin.x + 32, y: 13, width: 8, height: 14)

    viewContainer.addSubview(status)
    viewContainer.addSubview(arrow)

    return viewContainer
}