//
//  SplashView.swift
//  warehouse
//
//  Created by Alexey Sidorov on 12/11/2018.
//  Copyright © 2018 Eleview inc. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class FriendView: BaseView {
    private let disposeBag = DisposeBag()
    var currentViewModel: FriendViewModel!
    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        self.defaultBackground = false
        self.whiteColorStatusBar = true

        super.viewDidLoad()

        currentViewModel = (viewModel as? FriendViewModel)

        TableView.separatorColor = UIColor.clear
        TableView.separatorStyle = .none
        TableView.rowHeight = 62
        TableView.register(UINib(nibName: "UserItemCell", bundle: nil), forCellReuseIdentifier: "UserItemCell")

        binding()
    }

    func binding() {
        currentViewModel.dataSource.asObservable().bind(to: self.TableView.rx.items) { (tableView, row, element) in
            let item = element as UserResponse
            let userCell = tableView.dequeueReusableCell(withIdentifier: "UserItemCell") as! UserItemCell
            userCell.item = nil
            userCell.setData(value: item)
            userCell.accessoryView = nil
            userCell.accessoryView = setDetailsView(cellHeigth: userCell.frame.height, item: item)

            return userCell

        }.disposed(by: disposeBag)

        Observable.zip(TableView.rx.itemSelected, TableView.rx.modelSelected(UserResponse.self))
                .bind(onNext: { [weak self] indexPath, item in
                    if let sSelf = self {
                        sSelf.TableView.deselectRow(at: indexPath, animated: true)
                        sSelf.currentViewModel.itemSelectCommand.onNext(item)
                    }
                }).disposed(by: disposeBag)
    }
}
