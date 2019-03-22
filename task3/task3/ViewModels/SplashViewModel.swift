//
//  SplashViewModel.swift
//  warehouse
//
//  Created by Alexey Sidorov on 12/11/2018.
//  Copyright © 2018 Eleview inc. All rights reserved.
//

import Foundation
import RxSwift

public class SplashViewModel: BaseViewModel {
    let _navigationService: NavigationService!
    private let disposeBag = DisposeBag()

    init(navigationService: NavigationService) {
        _navigationService = navigationService
    }

    override func activate() {
        super.activate()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self._navigationService.showViewModel(viewModel: UsersViewModel.self, navigationController: true,
                    root: true, animation: true)
        }
    }
}
