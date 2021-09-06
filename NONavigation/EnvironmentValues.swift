//
//  EnvironmentValues.swift
//  NONavigation
//
//  Created by Deo on 2021/9/3.
//

import SwiftUI

private struct NOObserverStorageKey: EnvironmentKey {
    static let defaultValue: NOObserverStorage = NOObserverStorage()
}

extension EnvironmentValues {
    var noobserverStorage: NOObserverStorage {
        get { self[NOObserverStorageKey.self] }
        set { self[NOObserverStorageKey.self] = newValue }
    }
}
