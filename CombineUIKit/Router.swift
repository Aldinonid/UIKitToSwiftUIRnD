//
//  Router.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-22.
//

import SwiftUI

enum AppRoute: Equatable {
	case ThirdView
	case FourView
}


struct ContentView: View {
	
	@ObservedObject var router = Router(initial: AppRoute.ThirdView)
	
	var body: some View {
		RouterHost(router: router) { route in
			switch route {
				case .ThirdView: ThridView()
				case .FourView: FourView()
			}
		}
		.environmentObject(router)
		.navigationBarHidden(true)
	}
}


class Router<Route: Equatable>: ObservableObject {
	
	var routes = [Route]()
	var onPush: ((Route) -> Void)?
	
	init(initial: Route? = nil) {
		if let initial = initial {
			routes.append(initial)
		}
	}
	
	func push(_ route: Route) {
		routes.append(route)
		
		// notify listener
		onPush?(route)
	}
	
}


struct RouterHost<Route: Equatable, Screen: View>: UIViewControllerRepresentable {
	
	let router: Router<Route>
	
	@ViewBuilder
	let builder: (Route) -> Screen
	
	func makeUIViewController(context: Context) -> UINavigationController {
		let navigation = UINavigationController()
		
		for route in router.routes {
			navigation.pushViewController(
				UIHostingController(rootView: builder(route)), animated: false
			)
		}
		
		router.onPush = { route in
			navigation.pushViewController(
				UIHostingController(rootView: builder(route)), animated: true
			)
		}
		
		return navigation
	}
	
	func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
	}
	
	typealias UIViewControllerType = UINavigationController
}
