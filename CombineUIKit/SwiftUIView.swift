//
//  SwiftUIView.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-22.
//

import SwiftUI

struct TableSwiftUIView: View {
	
	let fruits: [String] = ["Apple", "Orange", "Banana"]
	
    var body: some View {
		 VStack {
			 Text("This is SwiftUI Label")
				 .font(.headline)
				 .foregroundColor(.red)
			 
			 List {
				 Section(
					header:
						HStack {
							Text("SwiftUI Table")
							Image(systemName: "flame.fill")
						}
						.font(.headline)
						.foregroundColor(.orange)
				 ) {
					 ForEach(fruits, id: \.self) { fruit in
						 Text(fruit)
					 }
				 }
			 }
			 .listStyle(.plain)
		 }
    }
}

struct DataModel: Hashable {
	let month: String
	let sum: Int
}

struct ChartView: View {
	
	let datas: [DataModel] = [
		DataModel(month: "Jan", sum: 140),
		DataModel(month: "Feb", sum: 240),
		DataModel(month: "Mar", sum: 440),
		DataModel(month: "Apr", sum: 345),
		DataModel(month: "May", sum: 234),
		DataModel(month: "Jun", sum: 267),
		DataModel(month: "Jul", sum: 233),
		DataModel(month: "Aug", sum: 313),
		DataModel(month: "Sep", sum: 374),
		DataModel(month: "Nov", sum: 40),
	]
	
	var body: some View {
		VStack {
			Text("SwiftUI Chart")
			
			HStack {
				ForEach(datas, id: \.self) { data in
					VStack {
						Spacer()
						Rectangle()
							.fill(Color.green)
							.frame(width: 15, height: CGFloat(data.sum))
						
						Text(data.month)
					}
				}
			}
		}
	}
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
		 ChartView()
    }
}
