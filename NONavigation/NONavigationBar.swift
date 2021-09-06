//
//  NONavigationBar.swift
//  NONavigation
//
//  Created by Deo on 2021/9/3.
//

import SwiftUI

public struct NONavigationBar: View {
    @EnvironmentObject private var navigation:NONavigation
    @ObservedObject private var barManager:NONavigationBarManager
    @State private var barHeight:CGFloat? = nil
    @State private var barWidth:CGFloat? = nil
    @State private var size:CGSize? = nil
    
    public init(){
        barManager = NONavigationBarManager()
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(alignment: .center, spacing: 0){
                self.barManager.backButton
                Spacer()
            }
            HStack(alignment: .center, spacing: 8){
                VStack(alignment: .leading, spacing: 4){
                    Text(self.barManager.title)
                        .font(.title)
                        .bold()
                        .lineLimit(1)
                        .padding(.horizontal, 8)
                }
                .background(GeometryReader { geometry in
                    Spacer().preference(key: SizePreferenceKey.self, value: geometry.size)
                }.onPreferenceChange(SizePreferenceKey.self){ value in
                    self.barHeight = value.height
                })
                .frame(maxHeight: self.barHeight != nil ? self.barHeight : .infinity)
                Spacer()
                HStack(spacing: 8){
                    if self.isHinit() {
                        Spacer()
                        Menu<MenuIcon, AnyView?>(content: {
                            self.barManager.trailingContainer
                        }, label: {MenuIcon()})
                    }else{
                        self.barManager.trailingContainer
                    }
                }
                .background(GeometryReader { geometry in
                    Spacer().preference(key: SizePreferenceKey.self, value: geometry.size)
                }.onPreferenceChange(SizePreferenceKey.self){ value in
                    self.size = value
                })
                .frame(maxHeight: self.barHeight != nil ? self.barHeight : .infinity)
            }
            Text(self.barManager.subtitle)
                .font(.subheadline)
                .lineLimit(1)
                .padding(.horizontal, 8)
        }
        .background(GeometryReader { geometry in
            Spacer().preference(key: SizePreferenceKey.self, value: geometry.size)
        }.onPreferenceChange(SizePreferenceKey.self){ value in
            self.barWidth = value.width
        })
        .padding(.vertical, 4)
        .onAppear(perform: {
            self.barManager.initNavigation(navigation)
        })
        .navigationBarHidden(true)
    }
}

//MARK: - set navigation bar title -
extension NONavigationBar{
    public func title(_ title:String)->NONavigationBar{
        self.barManager.title = title
        return self
    }
    
    public func subTitle(_ subTitle:String)->NONavigationBar{
        self.barManager.subtitle = subTitle
        return self
    }
}

//MARK: - show navigation bar back button -
extension NONavigationBar{
    public func showNavigationBack()->NONavigationBar{
        if self.barManager.backButton == nil {
            self.barManager.backButton = AnyView(BackButton())
        }
        return self
    }
    
    public func setNavigationBackText(_ content: String)->NONavigationBar{
        self.barManager.backButton = AnyView(BackButton(title:content))
        return self
    }
}

extension NONavigationBar{
    public func trailingContainer<Content>(@ViewBuilder content: () -> Content)->NONavigationBar where Content:View{
        self.barManager.trailingContainer = AnyView(content())
        return self
    }
    
    private func isHinit() -> Bool{
        let containerWidth = self.size?.width ?? 0
        let barWidth = self.barWidth ?? 0
        return containerWidth * 2 > barWidth
    }
}





#if DEBUG
struct NONavigationBarSimple_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            NONavigationBar().title("Main")
                .subTitle("sub Main")
                .showNavigationBack()
                .trailingContainer {
                    Text("menu1")
                    Text("menu2")
                }
            Text("body").font(.body)
            Spacer()
        }
        .environmentObject(NONavigation())
    }
}
#endif
