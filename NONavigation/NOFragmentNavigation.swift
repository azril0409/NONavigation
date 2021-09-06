//
//  FragmentNavigation.swift
//  NONavigation
//
//  Created by Deo on 2021/9/3.
//

import SwiftUI

public class NOFragmentNavigation: ObservableObject{
    @Published var isAnimationRunning:Bool = false
    @Published var fragmentView:AnyView? = nil
    @Published var fragmentName:String? = nil
    var storage:NOObserverStorage = NOObserverStorage()
    private var viewHistory:[AnyView] = []
    private var nameList:[String] = []
    
    public init(){
    }
    
    public init<Content:View>(_ content:Content, name:String? = nil){
        self.fragmentView = AnyView(content)
        self.fragmentName = name
    }
}

//MARK: back operation
extension NOFragmentNavigation{
    
    public func canBack() -> Bool{
        !self.viewHistory.isEmpty
    }
    
    public func back(){
        if viewHistory.isEmpty || self.nameList.isEmpty { return }
        self.isAnimationRunning = true
        self.fragmentView = nil
        withAnimation(NONavigation.DEFAULT_ANIMATION) {
            self.fragmentView = self.viewHistory.removeLast()
            self.fragmentName = self.nameList.removeLast()
            self.isAnimationRunning = false
        }
    }
    
    public func back(to name:String){
        self.isAnimationRunning = true
        withAnimation(NONavigation.DEFAULT_ANIMATION) {
            self.isAnimationRunning = false
            while self.fragmentName != name {
                if viewHistory.isEmpty || self.nameList.isEmpty { return }
                self.fragmentView = self.viewHistory.removeLast()
                self.fragmentName = self.nameList.removeLast()
            }
        }
    }
}

//MARK: Add operation
extension NOFragmentNavigation{
    public func present<Router:NoRouterType>(_ routerType:Router, name:String = ""){
        self.present(routerType.onCreateView(storage: self.storage), name:name)
    }
    
    public func present<Content:View>(_ presentView:Content, name:String = ""){
        self.present(AnyView(presentView), name:name)
    }
    
    public func present(_ view:AnyView, name:String = ""){
        guard let fragmentView = self.fragmentView else { return }
        self.viewHistory.append(fragmentView)
        self.nameList.append(self.fragmentName ?? "")
        self.isAnimationRunning = true
        self.fragmentView = nil
        DispatchQueue.main.async {
            withAnimation(NONavigation.DEFAULT_ANIMATION) {
                self.fragmentView = view
                self.fragmentName = name
                self.isAnimationRunning = false
            }
        }
    }
}

//MARK: Replace operation
extension NOFragmentNavigation{
    public func replace<Router:NoRouterType>(_ routerType:Router, name:String = ""){
        self.replace(routerType.onCreateView(storage: self.storage), name:name)
    }
    
    
    public func replace<Content:View>(_ content:Content, name:String = ""){
        self.replace(AnyView(content), name:name)
    }
    
    public func replace(_ view:AnyView, name:String = ""){
        self.isAnimationRunning = true
        self.fragmentView = nil
        DispatchQueue.main.async {
            withAnimation(NONavigation.DEFAULT_ANIMATION) {
                self.fragmentView = view
                self.fragmentName = name
                self.isAnimationRunning = false
            }
        }
    }
}
