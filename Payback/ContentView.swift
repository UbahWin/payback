//
//  ContentView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @State private var isShowingAddDuty: Bool = false

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        animation: .default
    )
    var items: FetchedResults<Item>

    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
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
            List {
                ForEach(items) { item in
                    NavigationLink {
                        AboutDutyView(duty: item)
                    } label: {
                        CellView(duty: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Payback", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddDuty = true }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $isShowingAddDuty) {
                        AddDutyView()
                    }
                }
            }
            Text("Select an item")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
