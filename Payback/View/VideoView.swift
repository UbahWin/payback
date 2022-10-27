//
//  VideoView.swift
//  Payback
//
//  Created by Иван Вдовин on 26.10.2022.
//

import SwiftUI
import AVKit

struct VideoView: View {
   var body: some View {
       VideoPlayer(player: AVPlayer(url:  Bundle.main.url(forResource: "zacarsh", withExtension: "mp4")!))
           .frame(height: 400)
    }
}
