//
//  SettingsView.swift
//  Seedling
//
//  Created by Brian Q on 11/28/22.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @State var testing: String = "test"
    @State var isLoggedIn: Bool = true
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: AccountSettingView(text: "Hi")) {
                    Text("Account")
                }
                NavigationLink(destination: NotificationSettingView(text: "Hi")) {
                    Text("Notifications")
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct SettingsPreviews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct AccountSettingView: View {
    var text: String
    var body: some View {
        Text("These are the account settings")
    }
}

struct NotificationSettingView: View {
    var text: String
    var body: some View {
        Text("These are the notification settings")
    }
}
