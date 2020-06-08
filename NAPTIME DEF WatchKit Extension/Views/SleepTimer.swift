//
//  SleepTimer.swift
//  NAPTIME DEF WatchKit Extension
//
//  Created by Denys Pashkov on 23/01/2020.
//  Copyright © 2020 Denys Pashkov. All rights reserved.
//

import SwiftUI

struct SleepTimer: View {
	
//	MARK: Basically this is a big timer that count down and when reach 0 start the wake up 
	
	@State var timerOver = false
    
    @State var waveMoving = false
    @State var isCounting : Bool = true
    
    @State var napTime = 0
    @State var hourLeft : Int = 0
    @State var minLeft : Int = 0
    @State var secondsLeft : Int = 59
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
       ZStack{
		if !timerOver{
			VStack {
			
			Image("SINE CURVE INERFACE TIMER")
				.offset(x: waveMoving ? -155 : 50)
				.animation(
					Animation.linear(duration: waveMoving ? 3 : 0)
						.repeatForever(autoreverses: false)
				)
				.onAppear(){ self.waveMoving.toggle() }
			
			Spacer()
				
				Text("\(self.hourLeft) : \(self.minLeft) : \(self.secondsLeft) Left").onAppear(perform: { self.setTime() })
					.onReceive(timer) { (_) in self.isCounting ? self.secondPassed() : nil }
					.font(.body)
					.multilineTextAlignment(.center)
				
				
				Spacer()
					
					HStack {
						
						Button(action: { self.isCounting.toggle() ; self.waveMoving.toggle()}) {
							Image(systemName: self.isCounting ? "pause" : "play")
						}
						Button(action: { self.setTime() }) {
							Image(systemName: "arrow.counterclockwise")
						}
					}.frame(width: CGFloat(150), height: CGFloat(50), alignment: .top)
						
						.padding(.bottom, -50.0)
					
				}
            .scaledToFit()
            .navigationBarTitle("Nap Time")
		}
			
		else {
			WakeUp()
		}
		
		}
    }
    
    private func setTime(){
        
        if self.napTime > 60 {
            self.hourLeft = 1
            self.minLeft = self.napTime - 60
        } else {
            
            self.minLeft = self.napTime
            
        }
        
        self.secondsLeft = 59
        
    }
    
    private func secondPassed(){
        
        self.secondsLeft -= 1
        
        if self.secondsLeft <= 0 {
                            
            self.secondsLeft = 59
            self.minLeft -= 1
        
            if self.minLeft < 0 {
            
                self.hourLeft -= 1
                    self.minLeft = 59
                
                if self.hourLeft < 0 {
                
                    self.isCounting.toggle()
                    
                    self.secondsLeft = 0
                    self.minLeft = 0
                    self.hourLeft = 0
                    
					timerOver = true
//                           wake me up, wake me up inside!!
                
                }
                
            }
            
        }
        
    }
    
}

struct SleepTimer_Previews: PreviewProvider {
    
    static var previews: some View {
        SleepTimer(napTime: 61)
    }
}
