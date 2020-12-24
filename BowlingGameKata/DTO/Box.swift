//
//  Box.swift
//  BowlingGameKata
//
//  Created by Macbook Pro 2017 on 12/23/20.
//  Copyright © 2020 DevTest. All rights reserved.
//

import Foundation

// Using a boxing technique is much easier in this case
// then relying on a 3rd party library like RxSwift

class Box<T> {
    typealias CallBack = (T) -> Void

    var callBack: CallBack?
    var value: T {
        didSet {
            callBack?(value)
        }
    }

    init(_ new: T) {
        value = new
    }
    func bind(_ callBack: CallBack?) {
        self.callBack = callBack
    }
    func bindAndCall(_ callBack: CallBack?) {
        self.callBack = callBack
        callBack?(value)
    }

}
