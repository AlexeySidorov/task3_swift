//
// Created by Alexey Sidorov on 11/11/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ContainerHelper {
    static let Instance = ContainerHelper()

    let MyContainer: Container = {
        let container = Container()

        // Repositories
        container.register(UserService.self) { r in
            UserRepository()
        }

        //Services
        container.register(NavigationService.self) { s in
            NavigatingService()
        }

        container.register(DialogService.self) { s in
            Dialog()
        }

        container.register(RestService.self) { s in
            RestApi()
        }

        // View models
        container.register(SplashViewModel.self) { r in
            SplashViewModel(navigationService: r.resolve(NavigationService.self)!)
        }

        container.register(UsersViewModel.self) { r in
            UsersViewModel(navigationService: r.resolve(NavigationService.self)!, userService: r.resolve(UserService.self)!,
                    restService: r.resolve(RestService.self)!, dialogService: r.resolve(DialogService.self)!)
        }

        container.register(FriendViewModel.self) { r in
            FriendViewModel(navigationService: r.resolve(NavigationService.self)!, userService: r.resolve(UserService.self)!)
        }

        // View
        container.storyboardInitCompleted(SplashView.self) { r, c in
            c.viewModel = r.resolve(SplashViewModel.self)
        }

        container.storyboardInitCompleted(UsersView.self) { r, c in
            c.viewModel = r.resolve(UsersViewModel.self)
        }

        container.storyboardInitCompleted(FriendView.self) { r, c in
            c.viewModel = r.resolve(FriendViewModel.self)
        }

        return container
    }()
}
