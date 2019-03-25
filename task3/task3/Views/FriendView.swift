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
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Status: UIView!
    @IBOutlet weak var Fruit: UIImageView!
    @IBOutlet weak var Age: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Phone: UILabel!
    @IBOutlet weak var Coordinates: UILabel!
    @IBOutlet weak var Address: UILabel!
    @IBOutlet weak var About: UILabel!
    @IBOutlet weak var TitleFriends: UILabel!

    override func viewDidLoad() {
        self.defaultBackground = false
        self.whiteColorStatusBar = true

        super.viewDidLoad()

        currentViewModel = (viewModel as? FriendViewModel)

        TableView.separatorColor = UIColor.clear
        TableView.separatorStyle = .none
        TableView.rowHeight = 62
        TableView.register(UINib(nibName: "UserItemCell", bundle: nil), forCellReuseIdentifier: "UserItemCell")

        Status.layer.cornerRadius = 5;

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

        setBindingDetailsUser()
    }

    func setBindingDetailsUser() {
        currentViewModel.fruit.bind(onNext: { [weak self] fruit in
            if let sSelf = self {
                sSelf.Fruit.image = fruit.getImage()
            }
        }).disposed(by: disposeBag)

        currentViewModel.statusUser.bind(onNext: { [weak self] eyeColor in
            if let sSelf = self {
                sSelf.Status.backgroundColor = eyeColor.getColor()
            }
        }).disposed(by: disposeBag)

        currentViewModel.userName.bind(to: UserName.rx.text).disposed(by: disposeBag)
        currentViewModel.age.bind(to: Age.rx.text).disposed(by: disposeBag)
        currentViewModel.email.bind(to: Email.rx.text).disposed(by: disposeBag)
        currentViewModel.phone.bind(to: Phone.rx.text).disposed(by: disposeBag)
        currentViewModel.address.bind(to: Address.rx.text).disposed(by: disposeBag)
        currentViewModel.dateRegistered.bind(to: Date.rx.text).disposed(by: disposeBag)
        currentViewModel.coordinates.bind(to: Coordinates.rx.text).disposed(by: disposeBag)
        currentViewModel.about.bind(to: About.rx.text).disposed(by: disposeBag)
        currentViewModel.titleFriends.bind(to: TitleFriends.rx.text).disposed(by: disposeBag)

        let phoneTap = UITapGestureRecognizer()
        Phone.addGestureRecognizer(phoneTap)
        phoneTap.rx.event.bind(onNext: { [weak self] recognizer in
            if let sSelf = self {
                sSelf.currentViewModel.phoneTapCommand.onNext(())
            }
        }).disposed(by: disposeBag)

        let emailTap = UITapGestureRecognizer()
        Email.addGestureRecognizer(emailTap)
        emailTap.rx.event.bind(onNext: { [weak self] recognizer in
            if let sSelf = self {
                sSelf.currentViewModel.emailTapCommand.onNext(())
            }
        }).disposed(by: disposeBag)

        let coordinatesTap = UITapGestureRecognizer()
        Coordinates.addGestureRecognizer(coordinatesTap)
        coordinatesTap.rx.event.bind(onNext: { [weak self] recognizer in
            if let sSelf = self {
                sSelf.currentViewModel.coordinatesTapCommand.onNext(())
            }
        }).disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        About.sizeToFit()

        let headerView = TableView.tableHeaderView
        if let header = headerView {
            var frame = header.frame
            frame.size.height = About.frame.origin.y + About.frame.height + 60
            header.frame = frame
            TableView.tableHeaderView = header
        }
    }
}
