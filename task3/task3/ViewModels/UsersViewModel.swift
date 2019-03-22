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

public class UsersViewModel: BaseViewModel {
    let _navigationService: NavigationService!
    let _userService: UserService!
    let _restService: RestService!
    let _dialogService: DialogService!
    private let disposeBag = DisposeBag()
    let itemSelectCommand = PublishSubject<UserResponse>()
    var refreshUsers: BehaviorRelay<Any?> = BehaviorRelay(value: nil)
    var dataSource: BehaviorRelay<[UserResponse]> = BehaviorRelay(value: [])
    let updateCommand = PublishSubject<Void>()

    init(navigationService: NavigationService, userService: UserService, restService: RestService,
         dialogService: DialogService) {
        _navigationService = navigationService
        _userService = userService
        _restService = restService
        _dialogService = dialogService
    }

    override func initViewModel(value: Any?) {
        super.initViewModel(value: value)

        if (!_userService.getIsUsers() && _restService.getIsConnected()) {
            setUsers()
        } else if _userService.getIsUsers() {
            getUsers()
        } else {
            _dialogService.showDialog(title: "Users", message: "User list empty", isBottom: false)
                    .subscribe().disposed(by: disposeBag)
        }

        itemSelectCommand.subscribe({ [weak self] item in
            if let sSelf = self {
                guard let value = item.element else {
                    return
                }
                
                if !value.isActive { return }
                
                sSelf._navigationService.showViewModel(viewModel: FriendViewModel.self, value: value, root: false, animation: true)
            }
        }).disposed(by: disposeBag)

        updateCommand.subscribe({ [weak self] _ in
            if let sSelf = self {
                sSelf.setUsers()
            }
        }).disposed(by: disposeBag)
    }

    private func setUsers() {
        showProgressDialog.on(.next((true, "Please wait")))
        _restService.getUsers().subscribe(onNext: { [weak self] response in
            if let sSelf = self {
                guard let users = response else {
                    sSelf._dialogService.showDialog(title: "Users", message: "User list empty", isBottom: false)
                            .subscribe().disposed(by: sSelf.disposeBag)
                    return
                }

                sSelf._userService.addOrUpdateUsers(users: UserUtility.Instance.convertUsersResponseToUsers(users: users))
                sSelf.showProgressDialog.on(.next((false, "")))
                sSelf.getUsers()
            }
        }).disposed(by: disposeBag)
    }

    private func getUsers() {
        let users = _userService.getUsers()
        if users.count == 0 {
            return
        }

        var array = dataSource.value
        if array.count > 0 {
            array.removeAll()
        }

        dataSource.accept(array)
        dataSource.accept(UserUtility.Instance.convertUsersToUsersResponse(users: users))
        refreshUsers.accept(nil)
    }
}
