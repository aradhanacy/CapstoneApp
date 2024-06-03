//
//  MainScreenView.swift
//  CapstoneApp
//
//  Created by 64001315 on 3/14/24.
//

import SwiftData
import SwiftUI

struct MainScreenView: View {
    @State private var showEditAppointmentView = false
    
    var body: some View {
        NavigationStack {
            EmptyView()
        }
        .navigationTitle("Appointments")
        .navigationDestination(isPresented: $showEditAppointmentView) {
            EditAppointmentView(currentDate: Date()).navigationBarBackButtonHidden(true)
        }
        .toolbar {
            Button("Make Appointment", systemImage: "plus", action: { showEditAppointmentView = true})
        }
    }
}

#Preview {
    MainScreenView()
}
