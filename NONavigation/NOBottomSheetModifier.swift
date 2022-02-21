//
//  NOBottomSheetModifier.swift
//  NONavigation
//
//  Created by Deo on 2021/9/3.
//

import SwiftUI

public struct NOBottomSheetModifier:ViewModifier{
    @EnvironmentObject private var bottomSheetManager:NOBottomSheetManager
    @State private var bottomSheetY:CGFloat = 0
    @State private var bottomSheetHeight:CGFloat = 0
    
    public init(){}
    
    public func body(content: Content) -> some View {
        return content
            .overlay(VStack{
                Spacer()
                if self.bottomSheetManager.bottomSheetView != nil {
                    self.bottomSheetManager.bottomSheetView
                        .background(self.bottomSheetBackground())
                        .offset(y:self.bottomSheetY)
                        .gesture(DragGesture()
                                    .onChanged{ value in
                                        if value.translation.height > 0 {
                                            self.bottomSheetY = value.translation.height
                                        }
                                    }.onEnded{ value in
                                        if self.bottomSheetHeight * 0.5 < abs(self.bottomSheetY){
                                            self.bottomSheetManager.dismissBottomSheet()
                                        }
                                        withAnimation(.spring()){
                                            self.bottomSheetY = 0
                                        }
                                    })
                        .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(self.bottomSheetManager.bottomSheetView != nil ? 0.3 : 0).transition(.opacity)))
    }
    
    private func bottomSheetBackground() -> some View{
        GeometryReader { geometry in
            Color.white.preference(key: SizePreferenceKey.self, value: geometry.size)
        }.onPreferenceChange(SizePreferenceKey.self){ value in
            self.bottomSheetHeight = value.height
        }
    }
}
