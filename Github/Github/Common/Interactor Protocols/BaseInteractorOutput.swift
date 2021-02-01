//
//  BaseInteractorOutput.swift
//  Github
//
//  Created by Emrah Akgül on 27.01.2021.
//

import Foundation

protocol BaseInteractorOutput: class {
    func setLoading(shouldLoad: Bool)
}

extension BaseInteractorOutput {
    func setLoading(shouldLoad: Bool) {}
}
