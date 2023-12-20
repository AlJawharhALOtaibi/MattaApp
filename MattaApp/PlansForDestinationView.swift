//
//  PlansForDestinationView.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 07/06/1445 AH.
// No accessibility

import SwiftUI
import SwiftData

struct PlansForDestinationView: View {
    @Bindable var destination: Destination
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    NavigationLink(destination: ContentView()) {
                        Image(systemName: "xmark")
                            .font(.title)
                        .foregroundColor(.black)                                        }
                    .padding()
                    Spacer()
                    Text(destination.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.trailing, 100)
                }
                .padding(.bottom, 100)
                
                
            }
        }
    }
    
    
    struct DetailPage: View {
        @Bindable var destination: Destination
        
        var body: some View {
            let days = daysBetween(start: destination.startDate, end: destination.endDate)
            
            VStack {
                
                HStack { Text(destination.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    .padding(.trailing, 40)}
                
//
//                Picker<Text, <#SelectionValue: Hashable#>, ForEach<ClosedRange<Int>, Int, Text>>("Day", selection: <#Binding<_>#>) {
//                    ForEach(1...days, id: \.self) { day in
//                        Text("Day \(day)")}}
//
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//
                
                // Button to add a new Plan
                //                Button(action: {
                //                    isShowingAddTaskSheet.toggle()
                //                }) {
                //                    Text("New Plan")
                //                        .frame(maxWidth: .infinity)
                //                        .frame(height: 50)
                //                        .foregroundColor(.white)
                //                        .background(Color.black)
                //                        .cornerRadius(10)
                //                        .padding()
                //                }
                //                .sheet(isPresented: $isShowingAddTaskSheet) {
                //                    // Add Task Sheet
                //                    VStack {
                //                        TextField("Plan Name", text: $newTaskName)
                //                            .textFieldStyle(RoundedBorderTextFieldStyle())
                //                            .padding()
                //
                //                        TextField("Plan Time", text: $newTaskTime)
                //                            .textFieldStyle(RoundedBorderTextFieldStyle())
                //                            .padding()
                //
                //                        TextField("Description", text: $newTaskDescription)
                //                            .textFieldStyle(RoundedBorderTextFieldStyle())
                //                            .padding()
                
                
            }
        }
        
        
        
        // Calculate the number of days between two dates
        func daysBetween(start: Date, end: Date) -> Int {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.day], from: destination.startDate, to: destination.startDate)
            return components.day ?? 0
        }
    }
    
}

