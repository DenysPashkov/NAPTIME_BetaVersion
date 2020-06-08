//
//  FallAsleepAnalysis.swift
//  NAPTIME DEF WatchKit Extension
//
//  Created by Delia Cavalli on 23/01/2020.
//  Copyright © 2020 Delia Cavalli. All rights reserved.
//

import SwiftUI

struct FallAsleepAnalysis: View {
	
	@State var isCenter = true
	@State var isCenter2 = true
	@State var isAsleep = false
	
	let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
	
	let size = WKInterfaceDevice.current().screenBounds.size.width / 4.6
	
	let napTime : Int
	let healthCare = HKHeartRate()
	let sleepCare = HKSleepBeat()
	
	var body: some View {
		
		
		VStack {
			
			Spacer()
			
			ZStack {
				
				Image("CIRCLE SINE CURVE DEFINITIVO")
					.frame(width: size, height: size)
					.offset(x: isCenter ? 0:size)
					.rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
				
				Image("CIRCLE SINE CURVE DEFINITIVO")
					.frame(width: size, height: size)
					.offset(x: isCenter ? 0: -size)
					.rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
				
				Image("CIRCLE SINE CURVE DEFINITIVO")
					.frame(width: size, height: size)
					.offset(y: isCenter ? 0:size)
					.rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
				
				
				Image("CIRCLE SINE CURVE DEFINITIVO")
					.frame(width: size, height: size)
					.offset(y: isCenter ? 0: -size)
					.rotationEffect(Angle(degrees: isCenter2 ? 0 : 360))
			}
			.onAppear {
				
				let animation = Animation.linear(duration: 5)
				withAnimation(animation.repeatForever(autoreverses: true)) {
					self.isCenter = false
				}
				
				withAnimation(animation.repeatForever(autoreverses: false)) {
					self.isCenter2 = false
				}
			}
			
			NavigationLink(destination: SleepTimer(napTime: napTime), isActive: self.$isAsleep) {
				Text("Just relax \(String(self.healthCare.heartRateData ?? 0))").onReceive(timer) { (_) in
					print("Check health Rate")
					
					let isSleeping = self.healthCare.heartRateData ?? 0 <= (self.sleepCare.sleepHeartRate ?? 0) + 10
					if isSleeping {
						self.isAsleep = true
					} else {
						self.isAsleep = false
					}
				}
				.font(.footnote)
				.padding(.bottom, -60.0)
			}
				.hidden()
				.navigationBarTitle("Nap time")
		}
	}
}

struct FallAsleepAnalysis_Previews: PreviewProvider {
	static var previews: some View {
		FallAsleepAnalysis(napTime: 5)
	}
}

