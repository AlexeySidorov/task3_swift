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
            guard item.element != nil else {
                return
            }

        }).disposed(by: disposeBag)

        updateCommand.subscribe({ [weak self] _ in
            self?.setUsers()
        }).disposed(by: disposeBag)
    }

    private func setUsers() {
        showProgressDialog.on(.next((true, "Please wait")))
        _restService.getUsers().subscribe(onNext: { [weak self] response in

            guard let users = response else {
                self?._dialogService.showDialog(title: "Users", message: "User list empty", isBottom: false)
                        .subscribe().disposed(by: self!.disposeBag)
                return
            }

            self?._userService.addOrUpdateUsers(users: UserUtility.Instance.convertUsersResponseToUsers(users: users))
            self?.showProgressDialog.on(.next((false, "")))
            self?.getUsers()

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
