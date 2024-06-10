//
//  EventForm.swift
//  iOS_NanoDegree
//
//  Created by Ahad Albaqami on 6/10/24.
//

import SwiftUI

struct EventForm: View {
    @State private var title: String = ""
    @State private var eventDate = Date()
    @State private var textColor = Color.red
    @Binding var event: Events
    @Environment(\.presentationMode) var presentationMode
    
    var isEditing: Bool
    var onSave: ((Events) -> Void)? = nil

    var body: some View {
        VStack {
            Form {
                TextField("Title", text: $title)
                DatePicker("Date", selection: $eventDate, displayedComponents: [.date , .hourAndMinute])
                ColorPicker("Text Color", selection: $textColor)
            }
        }.navigationTitle("Add Event")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                title = event.title
                eventDate = event.date
                textColor = event.textColor
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let updatedEvent = Events(title: title, date: eventDate, textColor: textColor)
                        if isEditing {
                            event = updatedEvent
                        } else {
                            onSave?(updatedEvent)
                        }
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
    }
}

