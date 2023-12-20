//
//  DestinationListingView.swift
//  MattaApp
//
//  Created by AlJawharh AlOtaibi on 07/06/1445 AH.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse), SortDescriptor(\Destination.name)]) var destinations: [Destination]

    var body: some View {
        List {
            
            if destinations.isEmpty {
                Image("Explore")
                    .padding(.top,120)
                    .accessibility(label: Text("Explore Image"))

            } else {
                
                ForEach(destinations) { destination in
                    NavigationLink(value: destination) {
                        VStack(alignment: .leading) {
                            Text(destination.name)
                                .font(.headline)
                            
                            Text(destination.date.formatted(date: .long, time: .shortened))
                        } .accessibility(hint: Text("Tap to view details about \(destination.name)"))

                    }
                }
                .onDelete(perform: deleteDestinations)
            }
        }  .listStyle(PlainListStyle())
         //  .background(Color.white)
    }
    init(sort: SortDescriptor<Destination>, searchString: String) {
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        }, sort: [sort])
    }

    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
