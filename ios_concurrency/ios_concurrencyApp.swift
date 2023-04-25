//
//  ios_concurrencyApp.swift
//  ios_concurrency
//
//  Created by Denis Schüle on 24.04.23.
//

import SwiftUI

@main
struct ios_concurrencyApp: App {
    
    
    var body: some Scene {
        WindowGroup {
            UsersListView()
                .onAppear{
                    UserDefaults.standard.setValue(false, forKey:"_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
