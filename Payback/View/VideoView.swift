//
//  VideoView.swift
//  Payback
//
//  Created by Иван Вдовин on 26.10.2022.
//

import SwiftUI
import AVKit

struct VideoView: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "zacarsh", withExtension: "mp4")!)
   var body: some View {
           VideoPlayer(player: player)
               .frame(width: 400, height: 300, alignment: .center)
   }
}
