//
//  NCoverViewManager.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//
import SwiftUI

public class NOMaskViewManager:ObservableObject{
    @Published var coverView:AnyView? = nil
    private var pmvm:NOMaskViewManager?
    private let delegate:NOObserverDelegate
    private let storage:NOObserverStorage
    
    init(delegate:NOObserverDelegate, storage:NOObserverStorage, pmvm:NOMaskViewManager?) {
        self.delegate = delegate
        self.storage = storage
        self.pmvm = pmvm
    }
    
    public func cover<Content:View>(_ coverView:Content){
        DispatchQueue.global(qos: .background).async {
            self.coverAnyView(AnyView(NORootViewCreator(coverView)
                                .setDelegate(self.delegate)
                                .setStorage(self.storage)
                                .setNOMaskViewManager(self)
                                .build()))
        }
    }
    
    public func cover<Router:NoRouterType>(_ routerType:Router){
        DispatchQueue.global(qos: .background).async {
            self.coverAnyView(AnyView(NORootViewCreator(routerType)
                                .setDelegate(self.delegate)
                                .setStorage(self.storage)
                                .setNOMaskViewManager(self)
                                .build()))
        }
    }
    
    private func coverAnyView(_ coverView:AnyView){
        DispatchQueue.main.async {
            withAnimation(NONavigation.DEFAULT_ANIMATION) {
                self.coverView = coverView
            }
        }
    }
    
    public func canDismiss() -> Bool{
        if self.coverView != nil{
            return true
        }else if let pmvm = self.pmvm{
            return pmvm.coverView != nil
        }else{
            return false
        }
    }
    
    public func dismiss(){
        withAnimation(NONavigation.DEFAULT_ANIMATION) {
            if self.coverView != nil{
                self.coverView = nil
            }else if let pmvm = self.pmvm{
                pmvm.coverView  = nil
            }
        }
    }
}
