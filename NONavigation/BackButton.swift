//
//  BackButton.swift
//  NONavigation
//
//  Created by Deo on 2021/9/6.
//

import SwiftUI

public struct BackButton: View {
    @EnvironmentObject var navigation:NONavigation
    var title:String? = nil
    
    public var body: some View {
        Button(action: { self.navigation.dismiss() }, label: {
            HStack{
                Image.init(systemName: "chevron.left")
                Text(getText())
                Spacer().frame(maxWidth: 64)
            }.frame(minWidth: 64)
        })
    }
    
    private func getText() -> String{
        guard let title = self.title else {
            return navigation.getPreviouName() ?? ""
        }
        return title
    }
}
