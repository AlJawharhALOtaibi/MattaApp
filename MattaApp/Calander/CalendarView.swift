//
//  CalendarView.swift
//  MattaApp
//
//  Created by Bsmah Ali on 11/06/1445 AH.
//

import SwiftUI

struct calander: View {
    @State var tripName: String = ""
    @State var currentDate: Date = Date()

    
    var body: some View {
        NavigationView{
            VStack(spacing: 20){
                HStack{
                    Text("Trip Name: ").font(.title2)
                    TextField("", text: $tripName).frame(width: 243, height: 41).background(Color("TField")).cornerRadius(10).foregroundColor(Color.black)
                }.padding(.top,20
                ).padding(.bottom, 10.0)
                
                RoundedRectangle(cornerRadius: 20).frame(width:350 , height: 2).foregroundColor(Color("TField"))
                Text("Trip Duration").font(.title3).padding(.trailing, 240.0)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        tripDatePicker(currentDate: $currentDate)
                    }
                }
                Button(action: {}, label: {
                    Text("Next step").frame(width: 311, height: 48).background(Color.black).foregroundColor(.white).font(.title2).cornerRadius(16)
                }).padding(.bottom, 30.0)
            }.navigationTitle("New Trip")
        }
    }
}

#Preview {
    calander()
}
