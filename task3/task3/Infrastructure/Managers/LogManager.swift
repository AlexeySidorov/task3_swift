//
// Created by Alexey Sidorov on 25/11/2018.
// Copyright (c) 2018 Eleview inc. All rights reserved.
//

import Foundation
import SwiftyBeaver


class LogManager {
    static let Instance = LogManager()

    private let log = SwiftyBeaver.self
    private let console = ConsoleDestination()

    init() {
        console.format = "$DHH:mm:ss&d $L $M"
        log.addDestination(console)
    }

    func error(error: String) {
        #if DEBUG
        log.error(error)
        #else
        //TODO Добавить Crashlytics log
        #endif
    }

    func error(error: NSException) {
        #if DEBUG
        log.error(error)
        #else
        //TODO Добавить Crashlytics log
        #endif
    }

    func warning(message: String) {
        #if DEBUG
        log.warning(message)
        #endif
    }

    func info(message: String) {
        #if DEBUG
        log.info(message)
        #endif
    }

    func debug(name: String, message: String) {
        #if DEBUG
        log.debug("------------------------------------------------------Start - \(name)------------------------------------------------------")
        log.debug(message)
        log.debug("---------------------------------------------------------------------------------------------------------------------------")
        #endif
    }
}