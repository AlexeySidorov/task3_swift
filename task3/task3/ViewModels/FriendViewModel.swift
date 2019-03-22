//
//  SplashViewModel.swift
//  warehouse
//
//  Created by Alexey Sidorov on 12/11/2018.
//  Copyright © 2018 Eleview inc. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class FriendViewModel: BaseViewModel {
    let _navigationService: NavigationService!
    let _userService: UserService!
    let _dialogService: DialogService!
    private let disposeBag = DisposeBag()
    let itemSelectCommand = PublishSubject<UserResponse>()
    var dataSource: BehaviorRelay<[UserResponse]> = BehaviorRelay(value: [])

    init(navigationService: NavigationService, userService: UserService, dialogService: DialogService) {
        _navigationService = navigationService
        _userService = userService
        _dialogService = dialogService
    }

    override func initViewModel(value: Any?) {
        super.initViewModel(value: value)

        if let user = value as? UserResponse {

            if user.friends.count > 0 {
                var users = _userService.getFriends(friends: FriendUtility.Instance.convertFriendsResponseToFriends(users: user.friends))
                if users.count > 0 {
                    dataSource.accept(UserUtility.Instance.convertUsersToUsersResponse(users: users))
                }
            }

            itemSelectCommand.subscribe({ [weak self] item in
                if let sSelf = self {
                    guard let value = item.element else {
                        return
                    }

                    if !value.isActive {
                        return
                    }

                    sSelf._navigationService.showViewModel(viewModel: FriendViewModel.self, value: value, root: false, animation: true)
                }
            }).disposed(by: disposeBag)
        } else {
            _navigationService.backNavigation(animation: true)
        }
    }
}
