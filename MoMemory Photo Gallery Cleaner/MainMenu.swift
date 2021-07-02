//
//  MainMenu.swift
//  MoMemory Photo Gallery Cleaner
//
//  Created by Sachintha Herath on 2021-07-02.
//

import SwiftUI
import Foundation

struct MainMenuView: View{
    var body: some View{
        NavigationView{
            VStack(alignment: .leading){
                NavigationLink(destination: ContentView()) {
                    Text("Awesome Button")
                    .frame(minWidth: 0, maxWidth: 300)
                    .padding()
                    .foregroundColor(.white)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(40)
                    .font(.title)
                }
            }
        }
    }
}
