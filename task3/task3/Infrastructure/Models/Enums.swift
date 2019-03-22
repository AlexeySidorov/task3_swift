//
// Created by Alexey Sidorov on 2018-12-26.
// Copyright (c) 2018 Alexey Sidorov. All rights reserved.
//

import Foundation
import UIKit

public enum EyeColor: String, Codable{
    case Blue = "blue"
    case Green = "green"
    case Brown = "brown"
    case None = ""

    func convertRawValue(rawValue: String) -> EyeColor {
        switch rawValue {
        case "blue": return EyeColor.Brown
        case "green": return EyeColor.Green
        case "brown": return EyeColor.Brown
        default:
            return EyeColor.None
        }
    }

    func toString() -> String {
        return self.rawValue
    }

    func getColor() -> UIColor {
        switch self {
        case .Blue: return UIColor.blue
        case .Green: return UIColor.green
        case .Brown: return UIColor.brown
        default:
            return UIColor.clear
        }
    }
}

public enum FavoriteFruit: String, Codable {

    case Banana = "banana"
    case Apple = "apple"
    case Strawberry = "strawberry"
    case None = ""

    func convertRawValue(rawValue: String) -> FavoriteFruit {
        switch rawValue {
        case "banana": return FavoriteFruit.Banana
        case "apple": return FavoriteFruit.Apple
        case "strawberry": return FavoriteFruit.Strawberry
        default:
            return FavoriteFruit.None
        }
    }

    func toString() -> String {
        return self.rawValue
    }

    func getImage() -> UIImage? {
        switch self {

        case .Banana: return UIImage(named: "Banana")
        case .Apple: return UIImage(named: "Apple")
        case .Strawberry: return UIImage(named: "Strawberry")
        default:
            return nil
        }
    }
}
