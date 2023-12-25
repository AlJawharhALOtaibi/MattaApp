//
//  PlansForDestinationView.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 07/06/1445 AH.
// No accessibility

import SwiftUI
import SwiftData

struct PlansForDestinationView: View {
    @State private var plans: [Plan] = []
    @State private var selectedDay = 1
    let destination: Destination
    @Environment(\.modelContext) var modelContext1
    @State private var isAddingPlan = false
    @State private var newPlanName = ""
    @State private var newPlanEmoji = ""
    @State private var newPlanTime = Date()
    @State private var newPlanDetails = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Day", selection: $selectedDay) {
                    ForEach(0...daysBetween(start: destination.startDate, end: destination.endDate), id: \.self) { day in
                        Text("Day \(day)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List(plansForSelectedDay(), id: \.id) { plan in
                    CardView(plan: plan)
                }
                
                Button(action: {
                    isAddingPlan.toggle()
                }) {
                    Text("Add Plan")
                        .font(.headline)
                        .frame(width: 300, height: 50)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.leading)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                        .accessibility(label: Text("Navigate to next page"))
                }
                .sheet(isPresented: $isAddingPlan) {
                    AddPlanView(
                        newPlanName: $newPlanName,
                        newPlanEmoji: $newPlanEmoji,
                        newPlanTime: $newPlanTime,
                        newPlanDetails: $newPlanDetails,
                        destination: destination,
                        isPresented: $isAddingPlan
                    )
                    .environment(\.modelContext, modelContext1)
                }
                .padding()
                .navigationTitle("Plans for \(destination.name)")
            }
        }
    }
    
    // Function to calculate days between dates
    func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start, to: end)
        return components.day ?? 0
    }
    
    // Function to filter plans based on selected day
    func plansForSelectedDay() -> [Plan] {
        let calendar = Calendar.current
        return plans.filter { plan in
            if let day = calendar.dateComponents([.day], from: plan.time).day {
                return day == selectedDay
            }
            return false
        }
    }
}


struct AddPlanView: View {
       @Environment(\.modelContext) var modelContext
     //  var plans: [Plan] = []
       @State private var path = [Plan]()
       @Binding var newPlanName: String
       @Binding var newPlanEmoji: String
       @Binding var newPlanTime: Date
       @Binding var newPlanDetails: String
       let destination: Destination
       let emojiOptions = ["🚗", "🚕", "🚆", "🚁", "🚀", "🚤", "✈️", "🚂", "🚴‍♂️", "🚵‍♀️", "🚶‍♂️", "🚶‍♀️", "🛴", "🛵", "🏍️", "🛺", "🚲", "🚖", "🚡", "🚟", "🚈", "🚇", "🛸"]
       @Binding var isPresented: Bool
 
   
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Plan Details")) {
                    TextField("Name", text: $newPlanName)
                    TextField("Details", text: $newPlanDetails)
                    
                    Picker("Emoji", selection: $newPlanEmoji) {
                        ForEach(emojiOptions, id: \.self) { emoji in
                            Text(emoji)
                        }
                    }
                   
                    
                    DatePicker("Time", selection: $newPlanTime, displayedComponents: .hourAndMinute)
                }
                
                Section {
                    Button(action: addPlan) {
                        Text("Save Plan")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.leading)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                            .accessibility(label: Text("Save new plan"))
                    }
                }
            }
            .navigationTitle("Add Plan")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
        }
    }
    
    func addPlan() {
            let newPlan = Plan(
                name: newPlanName,
                emoji: newPlanEmoji,
                time: newPlanTime,
                details: newPlanDetails,
              destination: destination
            )
             modelContext.insert(newPlan)
             path = [newPlan]
        }
    
  
}

struct CardView: View {
    let plan: Plan
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(plan.name)
                .font(.headline)
            
            Text(plan.details)
                .foregroundColor(.secondary)
            
            Text(plan.emoji)
                .font(.largeTitle)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}

