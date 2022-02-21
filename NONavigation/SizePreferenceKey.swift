//
//  SizePreferenceKey.swift
//  NONavigation
//
//  Created by Deo on 2021/9/6.
//

import SwiftUI

class SizePreferenceKey:PreferenceKey{
    typealias Value = CGSize
    static var defaultValue: CGSize = CGSize(width: 0,height: 0)
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
