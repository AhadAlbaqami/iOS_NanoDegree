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
    @State private var showAlert = false
    
    @Binding var event: Events
    @Environment(\.presentationMode) var presentationMode
    
    var isEditing: Bool
    var onSave: ((Events) -> Void)? = nil

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $eventDate, displayedComponents: [.date, .hourAndMinute])
                    ColorPicker("Text Color", selection: $textColor)
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Event" : "Add Event")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if isEditing {
                title = event.title
                eventDate = event.date
                textColor = event.textColor
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    guard !title.isEmpty else {
                        showAlert = true
                        return
                    }
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Invalid Input"),
                message: Text("The title cannot be empty."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}
