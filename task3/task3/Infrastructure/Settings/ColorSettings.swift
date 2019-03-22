//
//  ColorSettings.swift
//  warehouse
//
//  Created by Alexey Sidorov on 20/11/2018.
//  Copyright © 2018 Eleview inc. All rights reserved.
//

import Foundation
import UIKit

class ColorSettings {
    static let Instance = ColorSettings()

    let primaryColor: UIColor = UIColor.init(hexString: "#7200CA")
    let secondaryColor: UIColor = UIColor.init(hexString: "")
    let lightDarkColor: UIColor = UIColor.init(hexString: "#D7D7D7")
    let redColor: UIColor = UIColor.init(hexString: "#FF0624")
    let separatorColor: UIColor = UIColor.init(hexString: "#D8D8D8")
    let errorColor: UIColor = UIColor.init(hexString: "#FF0624")
}
