//
//  WakeUp.swift
//  NAPTIME DEF WatchKit Extension
//
//  Created by Denys Pashkov on 24/04/2020.
//  Copyright © 2020 Denys Pashkov. All rights reserved.
//

import SwiftUI

struct WakeUp: View {
    var body: some View {
//		Present in the Definitive Edition sorry
		Text("Hello, World!").onAppear {
			playSound(sound: "Alarm", type: "mp3")
		}.onDisappear {
			stopMusic()
		}
		
    }
	
}

struct WakeUp_Previews: PreviewProvider {
    static var previews: some View {
        WakeUp()
    }
}
