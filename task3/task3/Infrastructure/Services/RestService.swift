//
// Created by Alexey Sidorov on 2018-12-28.
// Copyright (c) 2018 Alexey Sidorov. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import UIKit

public protocol RestService {
    func getUsers() -> Observable<[UserResponse]?>
    func getIsConnected() -> Bool
}

public class RestApi: RestService {
    let disposeBag = DisposeBag()

    public func getUsers() -> Observable<[UserResponse]?> {
        return Observable.create { observer in
            Alamofire.request("https://www.dropbox.com/s/s8g63b149tnbg8x/users.json?raw=1").responseJSON { response in

                if let json = response.result.value {

                    if let data = try? JSONSerialization.data(withJSONObject: json, options: []) {
                        let decoder = JSONDecoder()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss Z"
                        decoder.dateDecodingStrategy = .formatted(dateFormatter)

                        let result = try? decoder.decode([UserResponse].self, from: data)
                        observer.onNext(result)

                    } else {
                        LogManager.Instance.debug(name: "Users response: ", message: "Error serialization")
                        observer.onNext(nil)
                    }
                } else {
                    LogManager.Instance.debug(name: "Users response: ", message: "User list empty")
                    observer.onNext(nil)
                }
            }

            return Disposables.create()
        }
    }

    public func getIsConnected() -> Bool {
        return Connectivity.isConnectedToInternet()
    }
}

private class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
