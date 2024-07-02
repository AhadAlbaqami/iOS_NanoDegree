//
//  EventsView.swift
//  iOS_NanoDegree
//
//  Created by Ahad Albaqami on 6/10/24.
//

import SwiftUI

struct EventsView: View {
    @State private var events = [Events]()
    @State private var selectedEvent: Events?
    @State private var isAddingNewEvent = false
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach($events) { $event in
                        NavigationLink {
                            EventForm(event: $event, isEditing: true)
                        } label: {
                            EventRow(event: event)
                        }
                    }
                    .onDelete(perform: deleteEvent)
                }
                .navigationTitle("Events")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isAddingNewEvent = true
                        }) {
                            Image(systemName: "plus")
                                .foregroundColor(.indigo)
                        }
                    }
                }
                .navigationDestination(isPresented: $isAddingNewEvent) {
                    EventForm(event: .constant(Events(title: "", date: Date(), textColor: .red)), isEditing: false, onSave: { newEvent in
                        events.append(newEvent)
                        isAddingNewEvent = false
                    })
                }
                .navigationDestination(for: UUID.self) { id in
                    if let event = events.first(where: { $0.id == id }) {
                        EventForm(event: Binding(
                            get: { event },
                            set: { updatedEvent in
                                if let index = events.firstIndex(where: { $0.id == id }) {
                                    events[index] = updatedEvent
                                }
                            }
                        ), isEditing: true)
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            // Force view update to reflect real-time date changes
            events = events.sorted()
        }
    }

    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
    }
}

struct EventRow: View {
    var event: Events
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(event.title)
                .font(.system(.headline, weight: .bold))
                .foregroundColor(event.textColor)
            Text(dateDescription(for: event.date, relativeTo: Date()))
        }
    }
    
    func dateDescription(for date: Date, relativeTo anotherDate: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: date, relativeTo: anotherDate)
    }
}

#Preview {
    EventsView()
}
