//
//  EditDestinationView.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 07/06/1445 AH.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination
    @State private var destinations: [Destination] = []
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Name", text: $destination.name)
                        .accessibility(label: Text("Destination Name"))

                    Section(header: Text("Start Date")) {
                        DatePicker("Start Date", selection: $destination.startDate, displayedComponents: [.date])
                            .accessibility(label: Text("Select Start Date"))
                    }
                    
                    Section(header: Text("End Date")) {
                        DatePicker("End Date", selection: $destination.endDate, displayedComponents: [.date])
                            .accessibility(label: Text("Select End Date"))
                    }
                    
                    NavigationLink(destination: PlansForDestinationView(destination: destination)) {
                        Text("Next Step")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.leading)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                            .accessibility(label: Text("Navigate to next page"))
                    }
                    .disabled(destination.name.isEmpty || destination.startDate > destination.endDate)
                    .padding(.top, 20)
                }
                .navigationTitle("New Trip!")
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("Destinations")
        }
    }
}
