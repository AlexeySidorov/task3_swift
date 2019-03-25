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
    let _deviceService: DeviceService!
    private let disposeBag = DisposeBag()
    let itemSelectCommand = PublishSubject<UserResponse>()
    var dataSource: BehaviorRelay<[UserResponse]> = BehaviorRelay(value: [])
    var userName: BehaviorRelay<String> = BehaviorRelay(value: "")
    var coordinates: BehaviorRelay<String> = BehaviorRelay(value: "")
    var email: BehaviorRelay<String> = BehaviorRelay(value: "")
    var address: BehaviorRelay<String> = BehaviorRelay(value: "")
    var age: BehaviorRelay<String> = BehaviorRelay(value: "")
    var dateRegistered: BehaviorRelay<String> = BehaviorRelay(value: "")
    var phone: BehaviorRelay<String> = BehaviorRelay(value: "")
    var about: BehaviorRelay<String> = BehaviorRelay(value: "")
    var titleFriends: BehaviorRelay<String> = BehaviorRelay(value: "")
    var statusUser: BehaviorRelay<EyeColor> = BehaviorRelay(value: EyeColor.None)
    var fruit: BehaviorRelay<FavoriteFruit> = BehaviorRelay(value: FavoriteFruit.None)
    var phoneTapCommand = PublishSubject<Void>()
    var emailTapCommand = PublishSubject<Void>()
    var coordinatesTapCommand = PublishSubject<Void>()

    init(navigationService: NavigationService, userService: UserService, dialogService: DialogService,
         deviceService: DeviceService) {
        _navigationService = navigationService
        _userService = userService
        _dialogService = dialogService
        _deviceService = deviceService
    }

    override func initViewModel(value: Any?) {
        super.initViewModel(value: value)

        if let user = value as? UserResponse {

            setDetailsUser(user: user)
            setDetailsUserCommand(user: user)

            if user.friends.count > 0 {
                let users = _userService.getFriends(friends: FriendUtility.Instance.convertFriendsResponseToFriends(users: user.friends))
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

    private func setDetailsUser(user: UserResponse) {
        var dateStr = "Not specific"
        if let date = user.registered.convert(format: "HH:mm dd.MM.yy") {
            dateStr = date
        }

        userName.accept(user.name)
        coordinates.accept("\(user.latitude), \(user.longitude)")
        email.accept(user.email)
        address.accept(user.address)
        age.accept("\(user.age)")
        dateRegistered.accept(dateStr)
        phone.accept(user.phone)
        about.accept(user.about)
        titleFriends.accept("Friends by \(user.name)")
        statusUser.accept(user.eyeColor)
        fruit.accept(user.favoriteFruit)
    }

    private func setDetailsUserCommand(user: UserResponse) {
        phoneTapCommand.subscribe(onNext: { [weak self] _ in
            if let sSelf = self {
                sSelf._deviceService.callPhone(phoneNumber: user.phone)
            }
        }).disposed(by: disposeBag)

        emailTapCommand.subscribe(onNext: { [weak self] _ in
            if let sSelf = self {
                sSelf._deviceService.sendEmail(email: user.email)
            }
        }).disposed(by: disposeBag)

        coordinatesTapCommand.subscribe(onNext: { [weak self] _ in
            if let sSelf = self {
                sSelf._deviceService.sendMapPoint(latitude: user.latitude, longitude: user.longitude)
            }
        }).disposed(by: disposeBag)
    }
}