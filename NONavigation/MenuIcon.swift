//
//  MenuIcon.swift
//  NONavigation
//
//  Created by Deo on 2021/9/6.
//

import SwiftUI

public struct MenuIcon: View {
    public var body: some View {
        VStack(spacing: 4){
            Capsule().frame(width: 24, height: 4)
            Capsule().frame(width: 24, height: 4)
            Capsule().frame(width: 24, height: 4)
        }.padding(.vertical, 8)
    }
}
