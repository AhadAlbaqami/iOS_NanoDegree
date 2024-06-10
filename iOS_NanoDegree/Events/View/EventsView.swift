//
//  EventsView.swift
//  iOS_NanoDegree
//
//  Created by Ahad Albaqami on 6/10/24.
//

import SwiftUI

struct EventsView: View {
    @State private var events = [Events]()
    let eventFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($events) { $event in
                        NavigationLink(destination: {
                            EventForm(event: $event, isEditing: true) }) {
                                eventRow(array: event)
                            }
                    }
                    .onDelete(perform: deleteEvent)
                }.navigationBarTitle("Events")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            NavigationLink(destination: {
                                EventForm(event: .constant(Events(title: "", date: Date(), textColor: .red)), isEditing: false, onSave: { newEvent in
                                    events.append(newEvent)
                                })
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.indigo)
                            }
                        }
                    }
            }
        }
    }
    
    @ViewBuilder func eventRow(array: Events) -> some View {
        VStack(alignment: .leading){
            Text(array.title).font(.system(.headline, weight: .bold)).foregroundColor(array.textColor)
            Text(array.date, formatter: eventFormatter)
        }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

#Preview {
    EventsView()
}
