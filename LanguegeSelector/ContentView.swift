//
//  ContentView.swift
//  LanguegeSelector
//
//  Created by 逸唐陳 on 2023/5/2.
//

import SwiftUI

struct ContentView: View {
    @Binding var lang: String
    
    var body: some View {
        VStack{
            Text(L10n.Login.Main.title)
                .padding()
            Button("English") {
                lang = "en"
            }
            .foregroundColor(.blue)
            Button("Chinese") {
                lang = "zh-Hant"
            }
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(lang: <#Binding<String>#>)
//    }
//}
