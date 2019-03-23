//
// Created by Alexey Sidorov on 2019-03-22.
// Copyright (c) 2019 Alexey Sidorov. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import MapKit

protocol DeviceService {
    func callPhone(phoneNumber: String)
    func sendMapPoint(latitude: Double, longitude: Double)
    func sendEmail(email: String) -> (Bool, String)
}

class DeviceInfo: DeviceService {
    func callPhone(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    func sendMapPoint(latitude: Double, longitude: Double) {
        let lat: CLLocationDegrees = latitude
        let lng: CLLocationDegrees = longitude

        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(lat, lng)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]

        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "My point"
        mapItem.openInMaps(launchOptions: options)
    }

    func sendEmail(email: String) -> (Bool, String) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.setToRecipients([email])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            UIApplication.shared.keyWindow?.rootViewController?.present(mail, animated: true, completion: nil)
        } else {
            return (false, "Application not found")
        }

        return (true, "")
    }
}
                                                                                                                                                                                                                                                                                                                                               
