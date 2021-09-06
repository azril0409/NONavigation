//
//  NoRouterType.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//
import SwiftUI

public protocol NoRouterType{
    func onCreateView(storage:NOObserverStorage) -> AnyView
}
