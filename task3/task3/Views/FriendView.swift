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
            self.setDetailsView(cell: userCell, item: item)
            
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
    
    private func setDetailsView(cell: UITableViewCell, item: UserResponse) {
        let viewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: cell.frame.height))
        let status = UIImageView(image: UIImage(named: item.isActive ? "ActiveUser" : "NotActiveUser"))
        let arrow = UIImageView(image: UIImage(named: "DisclosureIndicator"))
        status.frame = CGRect(x: 0, y: 8, width: 24, height: 24)
        arrow.frame = CGRect(x: status.frame.origin.x + 32, y: 13, width: 8, height: 14)
        
        viewContainer.addSubview(status)
        viewContainer.addSubview(arrow)
        
        cell.accessoryView = nil
        cell.accessoryView = viewContainer
    }
}
