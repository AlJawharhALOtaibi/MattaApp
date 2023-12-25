//
//  ContentView.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 07/06/1445 AH.
//

import SwiftData
import SwiftUI

var greeting: String {
    let hour = Calendar.current.component(.hour, from: Date())
    switch hour {
    case 6..<12: return "Good Morning!"
    case 12..<18: return "Good Afternoon!"
    default: return "Good Evening!"
    }
}

struct ContentView: View {
    @Environment(\.modelContext) var modelContext

    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText = ""

    var body: some View {
        NavigationStack(path: $path) {
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 4, height: 25)
                    .padding(.top,20)
                    .foregroundColor(.orange)
                    .accessibility(hidden: true)
               
                Text("Your Trips")
                    // .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top,20)
                  //  .padding(.leading)
                    .accessibility(label: Text("Your Trips"))
            }
            .padding(.leading, -180)
            .frame(maxWidth: .infinity)
        
           
            
            DestinationListingView(sort: sortOrder, searchString: searchText)
                .navigationTitle(greeting)
                .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
               
                    
                    Button(action: addDestination) {
                        Text("Add ")
                            .font(.headline)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.leading)
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 4)
                            .accessibility(label: Text("Navigate to next page"))
                    }

                 
        }
    }

    func addDestination() {
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
    }
}

#Preview {
    ContentView()
}
