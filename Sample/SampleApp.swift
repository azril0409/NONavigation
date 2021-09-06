//
//  SampleApp.swift
//  Sample
//
//  Created by Deo on 2021/9/2.
//

import SwiftUI
import NONavigation

@main
struct SampleApp: App, NOObserverDelegate {
    
    var body: some Scene {
        WindowGroup {
            NORootViewCreator(ContentView())
                .setName("Main")
                .setDelegate(self)
                .build()
            
        }
    }
    
    func onCreateObservableObject(storage: NOObserverStorage) {
    }
    
    func onInjectObject(sceneName: String?, injector: NONavigationInjector) {
    }
}
