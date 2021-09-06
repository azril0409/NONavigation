//
//  NOObserverStorage.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//

import SwiftUI

public class NOObserverStorage{
    var objects:[String:AnyObject] = [:]
    
    init(){}
    
    public func putObservableObject<T:ObservableObject>(object:T){
        let type = String(describing:object).components(separatedBy: ".").last!.components(separatedBy: ":").first!
        objects[type] = object
    }
    
    public func findObservableObject<T:ObservableObject>(type:T.Type) -> T?{
        let type = String(describing:type)
        let object = objects[type]
        return object as? T
    }
}
