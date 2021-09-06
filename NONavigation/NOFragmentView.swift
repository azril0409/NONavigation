//
//  FragmentView.swift
//  NONavigation
//
//  Created by Deo on 2021/9/3.
//
import SwiftUI

public struct NOFragmentView: View {
    @EnvironmentObject private var navigation:NONavigation
    @Environment(\.noobserverStorage) private var storage:NOObserverStorage
    @ObservedObject private var fragmentNavigation:NOFragmentNavigation
    
    public init(_ fragmentNavigation:NOFragmentNavigation){
        self.fragmentNavigation = fragmentNavigation
    }
    
    public var body: some View {
        return ZStack{
            if !self.fragmentNavigation.isAnimationRunning {
                self.fragmentNavigation.fragmentView?.transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .environmentObject(fragmentNavigation)
    }
}
