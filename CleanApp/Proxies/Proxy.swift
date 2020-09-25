//
//  WaekReferenceCycleProxy.swift
//  CleanApp
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Presentation
import Foundation

class WaekReferenceCycleProxy<Element: AnyObject> {
    private weak var instance: Element?
    
    init(instance: Element) {
        self.instance = instance
    }
}

extension WaekReferenceCycleProxy: AlertView where Element: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WaekReferenceCycleProxy: LoadingView where Element: LoadingView {
    func show() {
        instance?.show()
    }

    func hide() {
        instance?.hide()
    }
}
