//
//  ContentView.swift
//  Sample
//
//  Created by Deo on 2021/9/2.
//

import SwiftUI
import NONavigation

struct ContentView: View {
    @EnvironmentObject private var navigation:NONavigation
    private let fragmentNavigation = NOFragmentNavigation(Text("Fragment1"))
    
    var body: some View {
        VStack{
            NONavigationBar().title("Main")
                .trailingContainer {
                    Button(action: {
                        self.navigation.present(VStack{
                            NONavigationBar().title("Menu1").showNavigationBack()
                            Spacer()
                            Text("Menu1")
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        .transition(.move(edge: .bottom)))
                    }){
                        Text("menu1")
                    }
                    Button(action: {
                        self.navigation.present(VStack{
                            NONavigationBar().title("Menu2").showNavigationBack()
                            Spacer()
                            Text("Menu2")
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        .transition(.move(edge: .bottom)))
                    }){
                        Text("menu2")
                    }
                    Button(action: {
                        self.navigation.present(VStack{
                            NONavigationBar().title("Menu3").showNavigationBack()
                            Spacer()
                            Text("Menu3")
                            Spacer()
                        }
                        .padding()
                        .background(Color.yellow)
                        .transition(.move(edge: .bottom)))
                    }){
                        Text("menu3")
                    }
                }
            Text("Hello, world!")
            NOFragmentView(self.fragmentNavigation)
            NavigationLink("Go Page2", destination: Text("Page2").navigationTitle("Main2"))
            Button(action: {
                self.navigation.present(VStack{
                    NONavigationBar().title("Main3").showNavigationBack()
                    Spacer()
                    Text("Page3")
                    Spacer()
                }
                .padding()
                .background(Color.yellow)
                .transition(.move(edge: .bottom)))
            }, label: {
                Text("Go Page3")
            })
        }
        .padding()
        .transition(.move(edge: .bottom))
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ContentView()
        }
        .environmentObject(NONavigation())
    }
}
#endif
