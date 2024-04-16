//
//  LanguegeSelectorApp.swift
//  LanguegeSelector
//
//  Created by 逸唐陳 on 2023/5/2.
//

import SwiftUI

@main
struct LanguegeSelectorApp: App {
    @State(initialValue: "en") var lang: String
    
    var body: some Scene {
        WindowGroup {
            ContentView(lang: $lang)
                .environment(\.locale, .init(identifier: lang))
        }
    }
}
