//
//  NONavigationBarManager.swift
//  NONavigation
//
//  Created by Deo on 2021/9/6.
//

import SwiftUI

class NONavigationBarManager:ObservableObject{
    @Published var title:String = " "
    @Published var subtitle:String = ""
    @Published var backButton:AnyView? = nil
    @Published var trailingContainer:AnyView? = nil
    private var navigation:NONavigation? = nil
    
    func initNavigation(_ navigation:NONavigation){
        self.navigation = navigation
        self.initTitle()
    }
    
    func initTitle() {
        guard let navigation = self.navigation else {
            return
        }
        if self.title.isEmpty {
            let conentName = navigation.getConentName()
            self.title = conentName.isEmpty ? self.title : conentName
        }
    }
}
