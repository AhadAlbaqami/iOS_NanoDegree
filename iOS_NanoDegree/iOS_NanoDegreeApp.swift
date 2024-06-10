//
//  iOS_NanoDegreeApp.swift
//  iOS_NanoDegree
//
//  Created by Ahad Albaqami on 6/10/24.
//

import SwiftUI

@main
struct iOS_NanoDegreeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
