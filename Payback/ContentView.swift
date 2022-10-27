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
    @State private var isShowingVideo: Bool = false

    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.date, ascending: false)],
        animation: .default
    )
    var items: FetchedResults<Item>

//    func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//            do {
//                try viewContext.save()
//            } catch {
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
    

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
//                .onDelete(perform: deleteItems)
            }
            .navigationBarTitle("Payback", displayMode: .large)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddDuty = true }) {
                        Label("Добавить", systemImage: "plus")
                    }
                    .sheet(isPresented: $isShowingAddDuty) {
                        AddDutyView()
                    }
                }
                ToolbarItem {
                    Button(action: {
                        isShowingVideo = true
                    }) {
                        Label("", systemImage: "video")
                    }
                    .sheet(isPresented: $isShowingVideo) {
                        VideoView()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
