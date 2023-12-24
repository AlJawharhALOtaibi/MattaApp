//
//  tripDatePicker.swift
//  MattaApp
//
//  Created by Bsmah Ali on 11/06/1445 AH.
//
import SwiftUI

struct tripDatePicker: View {
    @Binding var currentDate: Date
    @State var startTrip: Date? = nil
    @State var endTrip: Date? = nil
    @State var rangeOfTrip: [Date] = []
    
    
    //Month update on arrow clicks
    @State var currentMonth: Int = 0
    let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    
    var body: some View {
        VStack(spacing:35){
            //Days
            
            HStack(spacing:0){
              
                    Text(extraDate()[0]).font(.title3).fontWeight(.semibold)
            
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                Button{
                   // withAnimation{
                        currentMonth -= 1
                 //   }
                }
            label:{
                Image(systemName: "chevron.left").foregroundColor(Color.orange).font(.title)}
                Text(extraDate()[1]).font(.title2)
                Button{
                  //  withAnimation{
                        currentMonth += 1
                   // }
                }
            label:{
                Image(systemName: "chevron.right").foregroundColor(Color.orange).font(.title)}}.padding(.horizontal)
            //Day view
            HStack(spacing: 0){
                ForEach(days, id: \.self){day in
                    Text(day).font(.callout).fontWeight(.semibold).frame(maxWidth: .infinity)}
            }
            
            // Dates
            //Lazy Grid..
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(extractDate()){value in
                    CardView(value: value).foregroundColor(.black)
                    // background for today
                    
                }
            }
            .onChange(of: currentMonth){
                newValue in
                //updating Month
                currentDate = getCurrentMonth()
                
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue)-> some View{
//
        VStack {
            if value.day != -1 {
                Button(action: {
                    // Action to perform when a day is tapped
                    if  startTrip == nil {
                        startTrip = value.date
                    }
                    else if endTrip == nil{
                        endTrip = value.date
                        self.rangeOfTrip = Date.rangeOFDates(from: startTrip!, to: endTrip!)
                        
                        
                    }
                    else if startTrip != nil || endTrip != nil{
                        startTrip = nil;endTrip = nil
                    }
                    print("Day \(value.day) tapped!")
                   
                })
                
                {
                    Text("\(value.day)").font(.title3.bold())
                }
                
            } else {
                Text("") // Placeholder for empty days
     
            }
        }
        .padding(.vertical, 8)
        .frame(height: 30, alignment: .top)
        

        .background{
            
            if (value.date == startTrip) || ( value.date == endTrip) {
                ZStack{
                    Color("orangeop").frame(width: 45, height: 35).padding(.top, 10.0)
                    Color.orange.frame(width: 40, height: 40).cornerRadius(30.0).padding(.top, 10.0)}
            }
            // color range between start and end
            else if let start = startTrip, let end = endTrip, rangeOfTrip.contains(value.date) {
                Color("orangeop").frame(width: 70, height: 35).padding(.top, 10.0)
            }}
       .background{
            if value.day != -1 &&  value.date.startOfDay == Date().startOfDay{
                Color.gray.opacity(0.30).frame(width: 40, height: 40).cornerRadius(30.0).padding(.top, 10.0)
            }
           // else {Color.clear}
            
       

            }
        }
    
    
    // button Style
    
    
    // checking Dates...
    func isSameDay(date1: Date, date2: Date)-> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    
    //extracting Year and Month to Display..
    func extraDate()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
        
    }
    
    func getCurrentMonth()-> Date{
        let calendar = Calendar.current
        
        //Current Month ..
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else{ return Date()
        }
        return currentMonth
        
    }
    
    
    func extractDate()->[DateValue]{
        let defaultDate = Date()
        Calendar.current.date(bySetting: .year, value: 2000, of: defaultDate)

        let calendar = Calendar.current
        
        //Current Month ..
        let currentMonth = getCurrentMonth()
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            //getting day...
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        // adding offest days to get exact week day..
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? defaultDate)
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateValue(day: -1, date: defaultDate), at: 0)
        }
        return days
    }
}
    


struct tripDatePicker_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()}
}





extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        
        //getting Start Date..
        let startDate = calendar.date(from:Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        
        // getting date.
        
        return range.compactMap { day -> Date in
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    // rang of Date by Start and end Trip
    static func rangeOFDates(from fromDate: Date, to toDate: Date) -> [Date] {
            var dates: [Date] = []
            var date = fromDate
            
            while date < toDate {
                dates.append(date)
                guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
                date = newDate
                
                
            }
         print(dates,"💆🏻‍♀️")
            return dates
        }
    
    // Day without Time
    var startOfDay: Date{
        Calendar.current.startOfDay(for: self)
    }
    
}

