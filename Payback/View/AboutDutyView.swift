//
//  AboutDutyView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI

struct AboutDutyView: View {
    @State private var showActionSheet = false
    
    @Environment(\.managedObjectContext) private var viewContext

    
    var duty: FetchedResults<Item>.Element
    
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ContentView().items[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Cумма")
                    Spacer()
                    Text(Formatter.getFormattedNumber(number: duty.sum) + "₽")
                }
                HStack {
                    Text("Кол-во человек")
                    Spacer()
                    Text(String(duty.peopleCount))
                }
                HStack {
                    Text("Дата")
                    Spacer()
                    Text(Formatter.getFormattedDate(date: duty.date!, format: "dd MMMM YYYY hh:mm"))
                }
                HStack {
                    Text("Долг")
                    Spacer()
                    Text(String(Formatter.getFormattedNumber(number: duty.duty) + "₽"))
                }
                HStack {
                    Text("Описание")
                    Spacer()
                    Text(duty.about!)
                }
            }
            .navigationBarTitle(duty.name ?? "Каршеринг")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showActionSheet = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(title: Text("Действия"),
                            buttons: [
                                .cancel(Text("Отмена")),
                                .default(
                                    Text("Изменить")
//                                        action: some
                                        ),
                                .destructive(
                                    Text("Удалить")
//                                    action: deleteItems
                                )
                            ]
                        )
                    }
                }
            }
        }
    }
}
