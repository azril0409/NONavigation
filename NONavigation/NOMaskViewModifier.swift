//
//  NOMaskViewModifier.swift
//  NONavigation
//
//  Created by Deo on 2021/9/3.
//
import SwiftUI

public struct NOMaskViewModifier:ViewModifier{
    @EnvironmentObject private var manager:NOMaskViewManager
    
    public init(){}
    
    public func body(content: Content) -> some View {
        return content
            .overlay(
                Group{
                    if self.manager.coverView != nil{
                        self.manager.coverView!.background(Color.white).clipShape(Rectangle()).transition(.move(edge: .bottom))
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
