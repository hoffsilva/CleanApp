//
//  WeakReferenceCycleProxy.swift
//  CleanApp
//
//  Created by Hoff Henry Pereira da Silva on 24/09/20.
//  Copyright © 2020 Hoff Henry Pereira da Silva. All rights reserved.
//

import Presentation
import Foundation

class WeakReferenceCycleProxy<Element: AnyObject> {
    private weak var instance: Element?
    
    init(instance: Element) {
        self.instance = instance
    }
}

extension WeakReferenceCycleProxy: AlertView where Element: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakReferenceCycleProxy: LoadingView where Element: LoadingView {
    func show() {
        instance?.show()
    }

    func hide() {
        instance?.hide()
    }
}
