//
// Created by Alexey Sidorov on 12/11/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class BaseView: UIViewController {
    var viewModel: BaseViewModel!
    var defaultBackground: Bool = false
    var whiteColorStatusBar: Bool = false
    var isShowProgressBar: Bool = false
    var isHideNavigationBar: Bool = false
    var statusBarStyle: UIStatusBarStyle = UIStatusBarStyle.default
    private let dispose = DisposeBag()
    private var progressView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height))
    private var titleProgress: UILabel = UILabel()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }

    override func viewDidLoad() {
        if (whiteColorStatusBar) {
            initNavigationBar()
            statusBarStyle = UIStatusBarStyle.lightContent
            setNeedsStatusBarAppearanceUpdate()
        }

        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(self.navigationBarTap))
        hideKeyboard.numberOfTapsRequired = 1
        navigationController?.navigationBar.addGestureRecognizer(hideKeyboard)

        super.viewDidLoad()

        intProgressDialog()

        viewModel.showProgressDialog.subscribe { [weak self] value in
            guard let element = value.element else {
                return
            }
            let (isShow, title) = element

            if isShow {
                self?.showProgressDialog(title: title)
            } else {
                self?.closeProgressDialog()
            }
        }.disposed(by: dispose)
    }

    @objc func navigationBarTap(_ recognizer: UIGestureRecognizer) {
        view.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.activate()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.deactivate()
    }

    func initNavigationBar() {
        navigationController?.navigationBar.barTintColor = ColorSettings.Instance.primaryColor
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        viewModel?.initViewModel(value: sender)
    }

    private func intProgressDialog() {
        progressView.backgroundColor = UIColor.black
        progressView.layer.opacity = 0.8

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        progressView.addSubview(container)

        let indicator = UIActivityIndicatorView(style: .white)
        container.addSubview(indicator)

        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()

        titleProgress.translatesAutoresizingMaskIntoConstraints = false
        titleProgress.textColor = UIColor.white
        titleProgress.textAlignment = .center
        titleProgress.font = .systemFont(ofSize: 17, weight: .medium)
        container.addSubview(titleProgress)

        indicator.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalToSystemSpacingBelow: container.topAnchor, multiplier: 0).isActive = true

        titleProgress.topAnchor.constraint(equalToSystemSpacingBelow: indicator.bottomAnchor, multiplier: 6).isActive = true
        titleProgress.leadingAnchor.constraint(equalToSystemSpacingAfter: container.leadingAnchor, multiplier: 0).isActive = true
        titleProgress.trailingAnchor.constraint(equalToSystemSpacingAfter: container.trailingAnchor, multiplier: 0).isActive = true

        container.centerXAnchor.constraint(equalToSystemSpacingAfter: progressView.centerXAnchor, multiplier: 0).isActive = true
        container.centerYAnchor.constraint(equalToSystemSpacingBelow: progressView.centerYAnchor, multiplier: 0).isActive = true
    }

    func showProgressDialog(title: String) {
        progressView.removeFromSuperview()
        titleProgress.text = title
        view.addSubview(progressView)
    }

    func closeProgressDialog() {
        progressView.removeFromSuperview()
    }
}
