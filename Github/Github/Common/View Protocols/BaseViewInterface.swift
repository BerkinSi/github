//
//  BaseViewInterface.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit

protocol BaseViewInterface: AnyObject {

    func preparePageTitle()
    func showError()
}

extension BaseViewInterface {

    func showError() {
        if let keyWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first,
           let rootVC = keyWindow.rootViewController {
            rootVC.showError()
        }
    }
}
