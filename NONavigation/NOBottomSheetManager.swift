//
//  NOBottomViewManager.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//
import SwiftUI

public class NOBottomSheetManager: ObservableObject {
    @Published var bottomSheetView:AnyView? = nil
    private var pbsm:NOBottomSheetManager?
    private let delegate:NOObserverDelegate
    private let storage:NOObserverStorage
    
    init(delegate:NOObserverDelegate, storage:NOObserverStorage, pbsm:NOBottomSheetManager?) {
        self.delegate = delegate
        self.storage = storage
        self.pbsm = pbsm
    }
    
    public func bottomSheet<Content:View>(_ bottomSheetView:Content){
        DispatchQueue.global(qos: .background).async {
            let sheetView = NORootViewCreator(bottomSheetView)
                .setDelegate(self.delegate)
                .setStorage(self.storage)
                .setNOBottomSheetManager(self)
                .build()
            self.bottomSheetAnyView(AnyView(sheetView))
        }
    }
    
    public func bottomSheet<Router:NoRouterType>(_ routerType:Router){
        DispatchQueue.global(qos: .background).async {
            let sheetView = NORootViewCreator(routerType)
                .setDelegate(self.delegate)
                .setStorage(self.storage)
                .setNOBottomSheetManager(self)
                .build()
            self.bottomSheetAnyView(AnyView(sheetView))
        }
    }
    
    private func bottomSheetAnyView(_ bottomSheetView:AnyView){
        DispatchQueue.main.async {
            withAnimation(NONavigation.DEFAULT_ANIMATION) {
                self.bottomSheetView = bottomSheetView
            }
        }
    }
    
    public func dismissBottomSheet(){
        withAnimation(NONavigation.DEFAULT_ANIMATION) {
            self.bottomSheetView = nil
        }
    }
}
