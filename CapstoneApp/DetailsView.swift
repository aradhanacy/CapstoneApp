//
//  DetailsView.swift
//  CapstoneApp
//
//  Created by 64001315 on 5/1/24.
//

import SwiftUI

struct DetailsView: View {
    @State var selectedDate: Date
    @State private var usage = ""
    @State private var numPeople = ""
    @State var halfHourAnswer: String?
    @State var selectedRoom: String
    @State var selectedTime: String
    let halfHourOptions = ["Yes, 1st half", "Yes, 2nd half", "No"]
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(.red)
                        
                        Text("\(selectedTime)")
                    }
                    
                    HStack {
                        Image(systemName: "mappin")
                            .foregroundColor(.red)
                        
                        Text("\(selectedRoom)")
                    }
                    
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.red)
                        
                        Text("\(selectedDate.dayOfTheWeek()), \(selectedDate.fullMonthDayYearFormat())")
                    }
                }
                .padding()
                
                Divider()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Enter Details")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    
                    Text("Is this for half hour use?")
                    
                    ForEach(halfHourOptions, id:\.self) { option in
                        HStack {
                            Button {
                                halfHourAnswer = option
                            } label : {
                                if halfHourAnswer == option {
                                    Circle()
                                        .shadow(radius: 3)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.red)
                                } else {
                                    Circle()
                                        .stroke()
                                        .shadow(radius: 3)
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.black)
                                }
                            }
                            Text(option)
                        }
                    }
                    
                    Text("What is this room being used for?")
                    
                    TextField("", text: $usage, axis: .vertical)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                        )
                    
                    Text("Around how many people are using this room?")
                    
                    TextField("", text: $numPeople, axis: .vertical)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke()
                        )
                        .padding(.bottom)
                    
                    Spacer()
                    
                    NavigationLink {
                        MainScreenView()
                    } label: {
                        Text("Confirm")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.red)
                            )
                    }
                    
                }
                .padding()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .navigationTitle("Details")
            
        /*Image of eagle??*/
        }
        
    }
}

struct SelectionCell: View {
    let halfHourOptions: String
    @Binding var halfHourAnswer: String?
    
    var body: some View {
        HStack {
            Text(halfHourOptions)
            Spacer()
            if halfHourOptions == halfHourAnswer {
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
        .onTapGesture {
            self.halfHourAnswer = self.halfHourOptions
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(selectedDate: Date(), selectedRoom: "Room A", selectedTime: "1st Hour")
    }
}
