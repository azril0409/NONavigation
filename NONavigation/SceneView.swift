//
//  SceneView.swift
//  NONavigation
//
//  Created by Deo on 2021/9/2.
//
import SwiftUI

struct SceneView: View {
    @EnvironmentObject private var navigation:NONavigation
    
    public var body: some View {
        NavigationView{
            ZStack{
                if !self.navigation.isAnimationRunning {
                    self.navigation.sceneView?.transition(.opacity)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .sheet(isPresented: self.$navigation.isSheetView, onDismiss: self.onDismiss, content: onSheetContent)
    }
    
    private func onDismiss(){
        self.navigation.onDismiss()
    }
    
    private func onSheetContent() -> some View{
        self.navigation.sheetView
    }
}
