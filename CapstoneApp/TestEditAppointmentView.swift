//
//  TestEditAppointmentView.swift
//  CapstoneApp
//
//  Created by 64001315 on 4/22/24.
//

import SwiftUI

struct TestEditAppointmentView: View {
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State var selectedMonth = 0
    @State var selectedDate = Date()
    
    var body: some View {
        
        HStack {
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedMonth -= 1
                }
            } label: {
                Image(systemName: "lessthan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 28)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Text(selectedDate.monthYearFormat())
                .font(.title2)
            
            Spacer()
            
            Button {
                withAnimation {
                    selectedMonth += 1
                }
            } label: {
                Image(systemName: "greaterthan")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 28)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        
        HStack {
            ForEach(days, id:\.self) { day in
                Text(day)
                    .font(.system(size: 12, weight: .medium))
                    .frame(maxWidth: .infinity)
            }
        }
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
            ForEach(fetchDates()) {value in
                ZStack {
                    if value.day != -1 {
                        Text("\(value.day)")
                    } else {
                        Text("")
                    }
                }
                .frame(width: 32, height: 32)
            }
        
        }
        .onChange(of: selectedMonth) { _ in
        selectedDate = fetchSelectedMonth()}
        
        
    }
    
    func fetchDates() -> [CalendarDates] {
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({ CalendarDates(day: calendar.component(.day, from: $0), date: $0) })
        
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDates(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        
        let month = calendar.date(byAdding: .month, value: selectedMonth, to: Date())
        return month!
    }
    
    
}

struct CalendarDates: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}

#Preview {
    TestEditAppointmentView()
}
