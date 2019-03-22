//
//  SplashView.swift
//  warehouse
//
//  Created by Alexey Sidorov on 12/11/2018.
//  Copyright © 2018 Eleview inc. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Swinject
import SwinjectStoryboard

class UsersView: BaseView {
    private let disposeBag = DisposeBag()
    var currentViewModel: UsersViewModel!
    var updateButton: UIBarButtonItem!
    @IBOutlet weak var TableView: UITableView!

    override func viewDidLoad() {
        self.defaultBackground = false
        self.whiteColorStatusBar = true

        super.viewDidLoad()

        currentViewModel = (viewModel as? UsersViewModel)

        TableView.separatorColor = UIColor.clear
        TableView.separatorStyle = .none
        TableView.rowHeight = 62
        TableView.register(UINib(nibName: "UserItemCell", bundle: nil), forCellReuseIdentifier: "UserItemCell")

        addBarButton()
        binding()
    }

    func addBarButton() {
        updateButton = UIBarButtonItem(title: "Update", style: .plain, target: self, action: nil)
        self.navigationItem.rightBarButtonItem = updateButton
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

        updateButton.rx.tap.bind(to: currentViewModel.updateCommand).disposed(by: disposeBag)

        currentViewModel.refreshUsers.subscribe({ [weak self] _ in
            if let sSelf = self {
                sSelf.TableView.reloadData()
            }
        }).disposed(by: disposeBag)
    }
}
