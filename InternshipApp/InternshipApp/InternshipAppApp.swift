//
//  InternshipAppApp.swift
//  InternshipApp
//
//  Created by Denis Tojaga on 12. 8. 2024..
//

import SwiftUI

@main
struct InternshipAppApp: App {
    
    /* Code for the TodoApp
    init() {
        NotificationManager.shared.requestAuthorization()
    }
     */
    
    var body: some Scene {
        WindowGroup {
            /* Code for the TodoApp
            CreateTaskView(
                taskViewModel: TaskViewModel(),
                profileViewModel: ProfileScreenViewModel(),
                reminderViewModel: ReminderViewModel())
             */
            
            LoginScreenView()
        }
    }
}
