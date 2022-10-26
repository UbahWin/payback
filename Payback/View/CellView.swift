//
//  CellView.swift
//  Payback
//
//  Created by Иван Вдовин on 26.10.2022.
//

import SwiftUI

struct CellView: View {
    var duty: FetchedResults<Item>.Element

    var body: some View {
        HStack {
            Image(duty.image ?? "Carsh")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80, alignment: .center)
            VStack(alignment: .leading, spacing: 5) {
                Text(duty.name ?? "Каршеринг")
                    .font(.title2)
                    .fontWeight(.bold)
                HStack {
                    Text(Formatter.getFormattedNumber(number: duty.sum) + "₽")
                    Text(Formatter.getFormattedDate(date: duty.date!))
                }
            }
        }
    }
}
