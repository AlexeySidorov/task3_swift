//
// Created by Alexey Sidorov on 12/11/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import RxSwift

public class BaseViewModel {
    let showProgressDialog = PublishSubject<(show: Bool, title: String)>()

    func activate() {
    }

    func deactivate() {
    }

    func initViewModel(value: Any?) {

    }
}
