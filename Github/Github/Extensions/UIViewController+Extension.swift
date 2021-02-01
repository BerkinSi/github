//
//  UIViewController+Extension.swift
//  Github
//
//  Created by Emrah Akgül on 25.01.2021.
//

import UIKit

extension UIViewController {
    static func initFromNib() -> Self {
        func instanceFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: self), bundle: nil)
        }
        return instanceFromNib()
    }
    
    func showError(title: String = "Error",
                   message: String = "An error happened. Please try again later",
                   preferredStyle: UIAlertController.Style =  UIAlertController.Style.alert) {
        let alert = UIAlertController(title: "Error", message: "An error happened. Please try again later", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "Ok", style: .default) { (action) in
            alert.dismiss(animated: false, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: false, completion: nil)
    }
}
