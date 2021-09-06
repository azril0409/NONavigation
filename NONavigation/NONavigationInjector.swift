//
//  NONavigationInjector.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//
import SwiftUI

public protocol NONavigationInjector {
    func injectEnvironmentObject<T>(_ object:T) where T : ObservableObject
    func injectEnvironmentObject<T>(type:T.Type) where T : ObservableObject
}

class NONavigationInjectorImpl:NONavigationInjector{
    var contentView:AnyView
    let sceneName:String?
    let storage:NOObserverStorage
    
    init(contentView:AnyView, sceneName:String?, storage:NOObserverStorage) {
        self.contentView = contentView
        self.sceneName = sceneName
        self.storage = storage
    }
    
    func injectEnvironmentObject<T>(_ object: T) where T : ObservableObject {
        contentView = AnyView(contentView.environmentObject(object))
    }
    
    func injectEnvironmentObject<T:ObservableObject>(type:T.Type){
        if let object = storage.findObservableObject(type: type) {
            contentView = AnyView(contentView.environmentObject(object))
        }
    }
}
