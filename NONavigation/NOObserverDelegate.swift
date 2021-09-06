//
//  NOObserverDelegate.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//

import Foundation


public protocol NOObserverDelegate{
    func onCreateObservableObject(storage:NOObserverStorage)
    func onInjectObject(sceneName:String?, injector :NONavigationInjector)
}

class NOObserverDelegateImpl:NOObserverDelegate{
    func onInjectObject(sceneName: String?, injector: NONavigationInjector) {
    }
    
    func onCreateObservableObject(storage: NOObserverStorage) {
    }
}



