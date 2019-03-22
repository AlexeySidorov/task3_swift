//
// Created by Alexey Sidorov on 20/11/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import UIKit
import Swinject
import SwinjectStoryboard

public protocol NavigationService {
    func showViewModel<T: AnyObject>(viewModel: T.Type, root: Bool, animation: Bool)
    func showViewModel<T: AnyObject>(viewModel: T.Type, navigationController: Bool, root: Bool, animation: Bool)
    func showViewModel<T: AnyObject>(viewModel: T.Type, value: Any, root: Bool, animation: Bool)
    func showViewModel<T: AnyObject>(viewModel: T.Type, value: Any, navigationController: Bool, root: Bool, animation: Bool)
    func backNavigation(animation: Bool)
}

public class NavigatingService: NavigationService {

    public func showViewModel<T: AnyObject>(viewModel: T.Type, root: Bool, animation: Bool) {
        showViewModels(viewModel: viewModel, value: nil, navigationController: false, root: root, animation: animation)
    }

    public func showViewModel<T: AnyObject>(viewModel: T.Type, navigationController: Bool, root: Bool, animation: Bool) {
        showViewModels(viewModel: viewModel, value: nil, navigationController: navigationController, root: root,
                animation: animation)
    }

    public func showViewModel<T: AnyObject>(viewModel: T.Type, value: Any, root: Bool, animation: Bool) {
        showViewModels(viewModel: viewModel, value: value, navigationController: false, root: root, animation: animation)
    }

    public func showViewModel<T: AnyObject>(viewModel: T.Type, value: Any, navigationController: Bool, root: Bool, animation: Bool) {
        showViewModels(viewModel: viewModel, value: value, navigationController: navigationController, root: root,
                animation: animation)
    }

    private func showViewModels<T: AnyObject>(viewModel: T.Type, value: Any?, navigationController: Bool, root: Bool,
                                              animation: Bool) {
        let viewModelName: String = genericName(className: viewModel)
        let screenName = viewModelName.replacingOccurrences(of: "ViewModel", with: "Screen")
        let storyboard = SwinjectStoryboard.create(name: screenName, bundle: nil, container: ContainerHelper.Instance.MyContainer)
        let controller = storyboard.instantiateViewController(withIdentifier: screenName)
        let segue = UIStoryboardSegue(identifier: "sendViewModel", source: controller,
                destination: controller)
        controller.prepare(for: segue, sender: value)

        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        if root {
            appDelegate?.window?.rootViewController = navigationController ?
                    UINavigationController(rootViewController: controller) : controller
        } else {
            appDelegate?.window?.endEditing(true)
        
            let navContainer = appDelegate?.window?.rootViewController as? UINavigationController
            let defaultContainer = appDelegate?.window?.rootViewController

            if navContainer != nil {
                navContainer?.pushViewController(controller, animated: animation)
            } else {
                defaultContainer?.present(controller, animated: animation)
            }
        }
    }

    private func genericName<T: AnyObject>(className: T.Type) -> String {
        let fullName: String = NSStringFromClass(className.self)
        let range = fullName.components(separatedBy: ".")
        if range.count == 2 {
            return range[1]
        } else {
            return fullName
        }
    }

    public func backNavigation(animation: Bool) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let navContainer = appDelegate?.window?.rootViewController as? UINavigationController
            appDelegate?.window?.endEditing(true)
            navContainer?.popViewController(animated: animation)
        }
    }
}
