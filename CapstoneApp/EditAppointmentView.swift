//
//  EditAppointmentView.swift
//  CapstoneApp
//
//  Created by 64001315 on 3/25/24.
//
import SwiftUI

struct EditAppointmentView: View {
    let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    @State var selectedMonth = 0
    @State var selectedDate = Date()
    @State var selectedWeekIndex = 0
    @State private var showMainView = false
    @State var dates: [Date] = []
    @State var selectedDates: Date?
    @State var selectedRoom: String = "Room A"
    @State var selectedTime: String = "1st Hour"
    let rooms = ["Room A", "Room B", "Room C"]
    let times = ["1st Hour", "2nd Hour", "3rd Hour", "4th Hour"]
    
    @State var currentDate: Date? = Date()
    
    var body: some View {
        NavigationStack {
            headerView
            
            daysHeaderView
            
            dateGridView
                .padding(.bottom)
            
            Divider()
                .padding(.bottom)
            
            Text("Date selected: \(selectedDate.dayOfTheWeek()), \(selectedDate.fullMonthDayYearFormat())")
                .padding(.bottom)
            
            Menu {
                ForEach(rooms, id: \.self) { item in
                    Button(action: {
                        selectedRoom = item
                    }) {
                        Text(item)
                    }
                }
            } label: {
                Text("Select a room")
                    .foregroundStyle(.red)
                    .padding(.bottom)
            }
            
            Menu {
                ForEach(times, id: \.self) { item in
                    Button(action: {
                        selectedTime = item
                    }) {
                        Text(item)
                    }
                }
            } label: {
                Text("Select a time")
                    .foregroundStyle(.red)
                    .padding(.bottom)
            }
            
            NavigationLink {
                DetailsView(selectedDate: selectedDate, selectedRoom: selectedRoom, selectedTime: selectedTime)
            } label: {
                Text("Next")
                Image(systemName: "arrowshape.right.fill")
            }
            .bold()
            .foregroundColor(.white)
            .padding()

            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.red)
            )
            
        }
        .navigationDestination(isPresented: $showMainView) {
            MainScreenView().navigationBarBackButtonHidden(true)
        }
        .toolbar {
            Button(action: {showMainView = true}) {
                Text("Cancel")
            }
        }
    }
    
    // Header View
    private var headerView: some View {
        HStack {
            Spacer()
            Text(selectedDate.monthYearFormat())
                .font(.title2)
            Spacer()
        }
        .padding()
    }
    
    // Days Header View
    private var daysHeaderView: some View {
        HStack {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.system(size: 12, weight: .medium))
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // Date Grid View
    private var dateGridView: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 20) {
            ForEach(fetchDates(), id: \.id) { value in
                if let currentDate = currentDate {
                    DateCellView(
                        value: value,
                        isCurrentWeekWeekday: selectedWeekDates.contains(where: { $0.isSameDay(as: value.date) }) && value.date.isWeekday,
                        currentDate: currentDate,
                        selectedDate: $selectedDate
                    )
                }
            }
        }
    }
    
    private func fetchDates() -> [CalendarDate] {
        let calendar = Calendar.current
        let currentMonth = fetchSelectedMonth()
        
        var dates = currentMonth.datesOfMonth().map({ CalendarDate(day: calendar.component(.day, from: $0), date: $0) })
        
        let firstDayOfWeek = calendar.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstDayOfWeek - 1 {
            dates.insert(CalendarDate(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
    
    func fetchSelectedMonth() -> Date {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .month, value: selectedMonth, to: Date()) ?? Date()
    }
    
    private var selectedWeekDates: [Date] {
        let calendar = Calendar.current
        let startDateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        
        // Find the start of the week (Sunday) and adjust to Monday
        var startDate = calendar.date(from: startDateComponents)!
        while calendar.component(.weekday, from: startDate) != 2 { // 2 represents Monday
            startDate = calendar.date(byAdding: .day, value: -1, to: startDate)!
        }
        
        var weekDates: [Date] = []
        for dayOffset in 0..<7 {
            let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate)!
            weekDates.append(date)
        }
        
        return weekDates
    }
}

// Date Cell View
struct DateCellView: View {
    let value: CalendarDate
    let isCurrentWeekWeekday: Bool
    let currentDate: Date
    @Binding var selectedDate: Date
    
    @State private var isSelected = false // Track whether the date is selected
    
    var body: some View {
        ZStack(alignment: .center) {
            if value.day != -1 {
                Button(action: {
                    self.selectedDate = value.date // Update selected date when tapped
                    self.isSelected = true // Mark the date as selected
                }) {
                    HStack(alignment: .center, spacing: 2) {
                        Text("\(value.day)")
                            .foregroundColor(isCurrentWeekWeekday ? .red : .black)
                            .fontWeight(isCurrentWeekWeekday ? .bold : .none)
                            // Highlights the current date
                            .background {
                                ZStack(alignment: .bottom) {
                                        Circle()
                                            .frame(width: 48, height: 48)
                                            .foregroundColor(isSelected ? .red.opacity(0.3) : .clear)
                                    
                                    if isCurrentDay(value.date) {
                                        Circle()
                                            .frame(width: 8, height: 8)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                    }
                }
                .disabled(isCurrentWeekWeekday == false)
            } else {
                Text("")
            }
        }
        .frame(width: 32, height: 32)
    }
    
    private func isCurrentDay(_ date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date, equalTo: currentDate, toGranularity: .day)
    }
}


struct CalendarDate: Identifiable {
    let id = UUID()
    var day: Int
    var date: Date
}

struct EditAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        EditAppointmentView()
    }
}
