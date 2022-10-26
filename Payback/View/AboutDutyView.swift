//
//  AboutDutyView.swift
//  Payback
//
//  Created by Иван Вдовин on 24.10.2022.
//

import SwiftUI

struct AboutDutyView: View {
        
    var duty: FetchedResults<Item>.Element
    
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
        }
    }
}
