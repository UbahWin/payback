//
//  AddDutyView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI

struct AddDutyView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State var sum: String = ""
    @State var peopleCount: Int16 = 2
    @State var date = Date()
    @State var about: String = ""
    @State var duty: Double = 0
    @State var image: String = "Carsh"
    @State var name: String = "Каршеринг"
    let percent: Int16 = 20
    
    enum DutyTypeEnum: String, CaseIterable, Identifiable {
        case carsh, other
        var id: Self { self }
    }
    @State var type: DutyTypeEnum = .carsh
    
    func takeType(type: DutyTypeEnum) {
        switch type {
        case .other:
            image = "Money"
            name = "Другое"
            duty = (NumberFormatter().number(from: sum)?.doubleValue ?? 0) / Double(peopleCount)
        default:
            duty = (NumberFormatter().number(from: sum)?.doubleValue ?? 0) / Double(peopleCount) * (1 + (Double(percent)/(100 * Double(peopleCount))))
            // (sum / peopleCount) * (1 + (percent/peopleCount))
        }
    }
    
    func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.date = date
            newItem.about = about
            newItem.id = UUID()
            newItem.sum = NumberFormatter().number(from: sum)?.doubleValue ?? 0.0 // TODO: refactor
            newItem.peopleCount = peopleCount
            newItem.duty = duty
            newItem.image = image
            newItem.name = name
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                NavigationView {
                    List {
                        Picker("Выберите тип", selection: $type) {
                            Text("Каршеринг").tag(DutyTypeEnum.carsh)
                            Text("Другое").tag(DutyTypeEnum.other)
                        }
                        Stepper(value: $peopleCount, in: 2 ... 30) {
                            Text("Кол-во человек: " + String(peopleCount))
                        }

                        HStack {
                            Text("Сумма: ")
                            Spacer()
                            TextField("Впишите...", text: $sum)
                                .keyboardType(.decimalPad)
                        }

                        DatePicker(selection: $date, label: { Text("Дата") })
                            .environment(\.locale, Locale(identifier: "ru_RU"))

                        TextField("Описание...", text: $about)

                        Button(action: {
                            takeType(type: type)
                            addItem()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Создать")
                        }
                    }.listStyle(.plain)
                }
                .navigationBarTitle("Добавить счёт", displayMode: .large)
                .navigationBarItems(
                    trailing:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Готово")
                    }
                )
                .padding()
            }
        }
    }
}
