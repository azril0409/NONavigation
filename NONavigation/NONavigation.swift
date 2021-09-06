//
//  NONavigation.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//

import SwiftUI
import UIKit
import Combine

public class NONavigation:ObservableObject{
    static let DEFAULT_ANIMATION = Animation.spring(response: 0.35, dampingFraction: 0.72, blendDuration: 0)
    var previousNavigation:NONavigation?
    var delegate:NOObserverDelegate
    var storage:NOObserverStorage
    /**
     
     */
    @Published var isAnimationRunning:Bool = false
    @Published var sceneView:AnyView? = nil
    @Published var contentName:String
    var sceneEdge:Edge.Set = .init()
    private var viewHistory:[AnyView] = []
    private var nameList:[String] = []
    /**
     
     */
    @Published var isSheetView:Bool = false
    @Published var sheetName:String? = nil
    @Published var sheetView:AnyView? = nil
    let onDismiss:()->Void
    
    public init() {
        previousNavigation = nil
        delegate = NOObserverDelegateImpl()
        storage = NOObserverStorage()
        self.contentName = ""
        onDismiss = {}
    }
}

//MARK: Get conent view name
extension NONavigation{
    public func getConentName()->String{
        self.contentName
    }
    
    public func getPreviouName() -> String? {
        self.nameList.last ?? (self.previousNavigation == nil ? nil : self.previousNavigation?.contentName)
    }
}


//MARK: Dismiss operation
extension NONavigation{
    
    public func canDismiss() -> Bool{
        !self.viewHistory.isEmpty
    }
    
    public func dismiss(){
        if viewHistory.isEmpty || self.nameList.isEmpty { return }
        self.isAnimationRunning = true
        self.sceneView = nil
        withAnimation(NONavigation.DEFAULT_ANIMATION) {
            self.sceneView = self.viewHistory.removeLast()
            self.contentName = self.nameList.removeLast()
            self.isAnimationRunning = false
        }
    }
    
    public func dismiss(to name:String){
        self.isAnimationRunning = true
        withAnimation(NONavigation.DEFAULT_ANIMATION) {
            self.isAnimationRunning = false
            while self.contentName != name {
                if viewHistory.isEmpty || self.nameList.isEmpty { return }
                self.sceneView = self.viewHistory.removeLast()
                self.contentName = self.nameList.removeLast()
            }
        }
    }
    
}

//MARK: Present operation
extension NONavigation{
    public func present<Router:NoRouterType>(_ routerType:Router, name:String = ""){
        self.present(routerType.onCreateView(storage: self.storage), name:name)
    }
    
    public func present<Content:View>(_ content:Content, name:String = ""){
        self.present(AnyView(content), name:name)
    }
    
    public func present(_ view:AnyView, name:String = ""){
        guard let sceneView = self.sceneView else { return }
        self.viewHistory.append(sceneView)
        self.nameList.append(self.contentName)
        self.isAnimationRunning = true
        self.sceneView = nil
        let impl = NONavigationInjectorImpl(contentView: view, sceneName: name, storage: self.storage)
        delegate.onInjectObject(sceneName: name, injector: impl)
        DispatchQueue.main.async {
            withAnimation(NONavigation.DEFAULT_ANIMATION) {
                self.sceneView = impl.contentView
                self.contentName = name
                self.isAnimationRunning = false
            }
        }
    }
}

//MARK: Replace operation
extension NONavigation{
    
    public func replace<Router:NoRouterType>(_ routerType:Router, name:String = ""){
        self.replace(routerType.onCreateView(storage: self.storage), name:name)
    }
    
    
    public func replace<Content:View>(_ content:Content, name:String = ""){
        self.replace(AnyView(content), name:name)
    }
    
    public func replace(_ view:AnyView, name:String = ""){
        self.isAnimationRunning = true
        self.sceneView = nil
        let impl = NONavigationInjectorImpl(contentView: view, sceneName: name, storage: self.storage)
        delegate.onInjectObject(sceneName: name, injector: impl)
        DispatchQueue.main.async {
            withAnimation(NONavigation.DEFAULT_ANIMATION) {
                self.sceneView = impl.contentView
                self.contentName = name
                self.isAnimationRunning = false
            }
        }
    }
}

//MARK:Sheet operation
extension NONavigation{
    public func sheet<Router:NoRouterType>(_ routerType:Router, name:String = "", _ onDismiss:@escaping ()->Void = {}){
        self.sheet(routerType.onCreateView(storage: self.storage), name:name, onDismiss)
    }
    
    public func sheet<Content:View>(_ presentView:Content, name:String = "", _ onDismiss:@escaping ()->Void = {}){
        self.sheet(AnyView(presentView), name:name, onDismiss)
    }
    
    public func sheet(_ sheetView:AnyView, name:String = "", _ onDismiss:@escaping ()->Void = {}){
        DispatchQueue.global(qos: .background).async {
            let sheetView = NORootViewCreator.init(sheetView)
                .setName(name)
                .setDelegate(self.delegate)
                .setStorage(self.storage)
                .setPreviousNavigation(self)
                .build()
            DispatchQueue.main.async {
                self.sheetView = AnyView(sheetView)
                self.isSheetView = true
            }
        }
    }
    
    public func canDismissSheet() -> Bool{
        return self.isSheetView || self.previousNavigation?.isSheetView == true
    }
    
    public func dismissSheet(){
        if self.isSheetView {
            self.isSheetView = false
            self.sheetView = .none
        }else if let viewModel = self.previousNavigation {
            viewModel.isSheetView = false
            viewModel.sheetView = .none
        }
    }
}
