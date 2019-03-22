//
//  SplashViewModel.swift
//  warehouse
//
//  Created by Alexey Sidorov on 12/11/2018.
//  Copyright © 2018 Eleview inc. All rights reserved.
//

import Foundation
import RxSwift

public class FriendViewModel: BaseViewModel {
    let _navigationService: NavigationService!
    let _userService: UserService!
    private let disposeBag = DisposeBag()

    init(navigationService: NavigationService, userService: UserService) {
        _navigationService = navigationService
        _userService = userService
    }

    override func initViewModel(value: Any?) {
        super.initViewModel(value: value)
    }

    override func activate() {
        super.activate()

    }

}
