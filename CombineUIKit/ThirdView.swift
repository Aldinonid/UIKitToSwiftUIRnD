//
//  ThirdView.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-22.
//

import SwiftUI
import PhotosUI

@MainActor
final class ThridViewModel: ObservableObject {
	
	@Published var fruits: [String] = [
		"apple", "orange", "banana", "peach"
	]
	@Published var veggies: [String] = [
		"tomato", "potato", "carrot"
	]
	
	func delete(indexSet: IndexSet) {
		fruits.remove(atOffsets: indexSet)
	}
	
	func move(indices: IndexSet, newOffset: Int) {
		fruits.move(fromOffsets: indices, toOffset: newOffset)
	}
	
	func add() {
		fruits.append("Coconut")
	}
	
}

struct ThridView: View {
	
	@ObservedObject private var vm = ThridViewModel()
	
	var body: some View {
		NavigationView {
			List {
				Section(
					header:
						HStack {
							Text("Fruits")
							Image(systemName: "flame.fill")
						}
						.font(.headline)
						.foregroundColor(.orange)
				) {
					ForEach(vm.fruits, id: \.self) { fruit in
						Text(fruit.capitalized)
							.font(.caption)
							.foregroundColor(.white)
							.padding(.vertical)
					}
					.onDelete(perform: { index in
						vm.delete(indexSet: index)
					})
					.onMove(perform: { indices, offset in
						vm.move(indices: indices, newOffset: offset)
					})
					.listRowBackground(Color.blue)
				}
				
				Section(header: Text("Veggies")) {
					ForEach(vm.veggies, id: \.self) { veggies in
						Text(veggies.capitalized)
					}
				}
			}
			.accentColor(.purple)
			.navigationBarTitle("Grocery List")
			.navigationBarItems(leading: EditButton(), trailing: addButton)
		}
		.accentColor(.red)
	}
	
	var addButton: some View {
		Button("Add", action: {
			vm.add()
		})
	}
	
}

struct ThridViewBootcamp_Previews: PreviewProvider {
	static var previews: some View {
		NavigationView {
			ThridView()
		}
	}
}
