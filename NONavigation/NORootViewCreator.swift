//
//  NORootViewCreator.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//

import SwiftUI


public class NORootViewCreator {
    private let contentView:AnyView?
    private let routerType:NoRouterType?
    private var name = ""
    private var navigation = NONavigation()
    private var edge = Edge.Set.init()
    private var delegate:NOObserverDelegate = NOObserverDelegateImpl()
    private var previousNavigation:NONavigation? = nil
    private var bsm:NOBottomSheetManager? = nil
    private var mvm:NOMaskViewManager? = nil
    private var storage:NOObserverStorage? = nil
    
    public init<Content:View>(_ contentView:Content){
        self.contentView = AnyView(contentView)
        self.routerType = nil
    }
    
    public init<Type:NoRouterType>(_ routerType:Type){
        self.contentView = nil
        self.routerType = routerType
    }
    
    public func setDelegate(_ delegate:NOObserverDelegate) -> NORootViewCreator{
        self.delegate = delegate
        return self
    }
    
    public func setEdge(_ edge:Edge.Set) -> NORootViewCreator{
        self.edge = edge
        return self
    }
    
    public func setName(_ name:String) -> NORootViewCreator{
        self.name = name
        return self
    }
    
    public func setNavigation(_ navigation:NONavigation) -> NORootViewCreator{
        self.navigation = navigation
        return self
    }
    
    func setStorage(_ storage:NOObserverStorage) -> NORootViewCreator {
        self.storage = storage
        return self
    }
    
    func setPreviousNavigation(_ navigation:NONavigation) -> NORootViewCreator{
        self.previousNavigation = navigation
        return self
    }
    
    func setNOBottomSheetManager(_ manager:NOBottomSheetManager) -> NORootViewCreator {
        self.bsm = manager
        return self
    }
    
    func setNOMaskViewManager(_ manager:NOMaskViewManager) -> NORootViewCreator {
        self.mvm = manager
        return self
    }
    
    public func build() -> some View{
        self.navigation.previousNavigation = previousNavigation
        self.navigation.delegate = delegate
        self.navigation.sceneEdge = edge
        let storage:NOObserverStorage
        if let s = self.storage {
            self.navigation.storage = s
            delegate.onCreateObservableObject(storage: s)
            storage = s
        }else{
            delegate.onCreateObservableObject(storage: self.navigation.storage)
            storage = self.navigation.storage
            
        }
        let view = SceneView()
            .edgesIgnoringSafeArea(edge)
            .environmentObject(self.navigation)
            .environmentObject(NOMaskViewManager(delegate: self.delegate, storage: storage, pmvm: self.mvm))
            .environmentObject(NOBottomSheetManager(delegate: self.delegate, storage: storage, pbsm: self.bsm))
            .environment(\.noobserverStorage, self.navigation.storage)
        if let contentView = contentView {
            self.navigation.sceneView = AnyView(contentView)
        }else if let routerType = routerType {
            self.navigation.sceneView = routerType.onCreateView(storage: storage)
        }else {
            self.navigation.sceneView = AnyView(EmptyView())
        }
        let impl = NONavigationInjectorImpl(contentView: AnyView(view), sceneName: name, storage: storage)
        delegate.onInjectObject(sceneName: self.name, injector: impl)
        self.navigation.contentName = name
        return impl.contentView
    }
}
