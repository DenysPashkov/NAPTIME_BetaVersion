//
//  ContentView.swift
//  NAPTIME DEF WatchKit Extension
//
//  Created by Delia Cavalli on 23/01/2020.
//  Copyright © 2020 Delia Cavalli. All rights reserved.
//


import SwiftUI
import UIKit

struct ContentView: View {
	var body: some View {
		
		List{
			NavigationLink(destination: FallAsleepAnalysis(napTime: 19)) {
				
				ZStack{
					Image("Apple_Watch_40mm_Copy_5")
						.resizable()
						
					HStack{
						VStack{
							HStack{
								Text("PowerNap")
								.font(.system(size: 20))
								.fontWeight(.bold)
								.multilineTextAlignment(.leading)
								
								Spacer()
							}
							
							HStack{
								Text("20 Mins")
								.font(.system(size: 14))
								.fontWeight(.regular)
								.multilineTextAlignment(.leading)
								Spacer()
							}
							
							Spacer()
						}.padding()
						Spacer()
					}
					
				}.frame(width: WKInterfaceDevice.current().screenBounds.size.width - 10, height: WKInterfaceDevice.current().screenBounds.size.width - 60)
				
				
				
			}.frame(width: WKInterfaceDevice.current().screenBounds.size.width - 10, height: WKInterfaceDevice.current().screenBounds.size.width - 60)
				.listRowPlatterColor(.clear)
			
			NavigationLink(destination: FallAsleepAnalysis(napTime: 89)) {
				
				ZStack{
					Image("Apple_Watch_40mm_Copy_9")
						.resizable()
						
					HStack{
						VStack{
							HStack{
								Text("LongNap")
								.font(.system(size: 20))
								.fontWeight(.bold)
								.multilineTextAlignment(.leading)
								
								Spacer()
							}
							
							HStack{
								Text("90 Mins")
								.font(.system(size: 14))
								.fontWeight(.regular)
								.multilineTextAlignment(.leading)
								Spacer()
							}
							
							Spacer()
						}.padding()
						Spacer()
					}
					
				}.frame(width: WKInterfaceDevice.current().screenBounds.size.width - 10, height: WKInterfaceDevice.current().screenBounds.size.width - 60)
				
				
				
			}
			.frame(width: WKInterfaceDevice.current().screenBounds.size.width - 10, height: WKInterfaceDevice.current().screenBounds.size.width - 60)
				.listRowPlatterColor(.clear)
		}
			.background(Color.yellow).listStyle(CarouselListStyle())
		
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
