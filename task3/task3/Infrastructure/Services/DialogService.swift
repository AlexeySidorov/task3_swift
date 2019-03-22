//
// Created by Alexey Sidorov on 04/12/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import RxSwift

protocol DialogService {
    func showDialog(title: String, message: String, isBottom: Bool) -> Observable<TypeButton>
    func showDialog(title: String, message: String, isBottom: Bool, primaryButtonName: String) -> Observable<TypeButton>
    func showDialog(title: String, message: String, isBottom: Bool, primaryButtonName: String, secondaryButtonName: String) -> Observable<TypeButton>
    func showInputDialog(title: String, message: String, placeholder: String) -> Observable<String?>
}

class Dialog: DialogService {

    func showDialog(title: String, message: String, isBottom: Bool) -> Observable<TypeButton> {
        return showDialog(title: title, message: message, isBottom: isBottom, primaryButtonName: "OK",
                secondaryButtonName: nil, bug: nil)
    }

    func showDialog(title: String, message: String, isBottom: Bool, primaryButtonName: String) -> Observable<TypeButton> {
        return showDialog(title: title, message: message, isBottom: isBottom, primaryButtonName: primaryButtonName,
                secondaryButtonName: nil, bug: nil)
    }

    func showDialog(title: String, message: String, isBottom: Bool, primaryButtonName: String, secondaryButtonName: String) -> Observable<TypeButton> {
        return showDialog(title: title, message: message, isBottom: isBottom, primaryButtonName: primaryButtonName,
                secondaryButtonName: secondaryButtonName, bug: nil)
    }

    func showInputDialog(title: String, message: String, placeholder: String) -> Observable<String?> {
        return Observable.create { observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = placeholder
            }

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (dialog) -> (Void) in
                guard let textField = alert.textFields?.first else {
                    return
                }

                alert.dismiss(animated: true, completion: nil)
                observer.on(.next(textField.text))
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (dialog) -> (Void) in
                alert.dismiss(animated: true, completion: nil)
            }))

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let defaultContainer = appDelegate.window!.rootViewController! as UIViewController
            defaultContainer.present(alert, animated: false, completion: nil)

            return Disposables.create()
        }
    }

    func showDialog(title: String, message: String, isBottom: Bool, primaryButtonName: String?,
                    secondaryButtonName: String?, bug: String?) -> Observable<TypeButton> {
        return Observable.create { observer in
            let alert = UIAlertController(title: title, message: message, preferredStyle: isBottom ? .actionSheet : .alert)
            alert.addAction(UIAlertAction(title: primaryButtonName, style: .default, handler: { (dialog) -> (Void) in
                alert.dismiss(animated: true, completion: nil)
                observer.on(.next(TypeButton.primary))
            }))

            if secondaryButtonName != nil {
                alert.addAction(UIAlertAction(title: secondaryButtonName, style: .cancel, handler: { (dialog) -> (Void) in
                    alert.dismiss(animated: true, completion: nil)
                    observer.on(.next(TypeButton.secondary))
                }))
            }

            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let defaultContainer = appDelegate.window!.rootViewController! as UIViewController
            defaultContainer.present(alert, animated: false, completion: nil)

            return Disposables.create()
        }
    }
}

enum TypeMessage {
    case error
    case info
    case message
}

enum TypeButton {
    case primary
    case secondary
}
