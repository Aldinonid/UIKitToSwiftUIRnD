//
//  ThirdViewController.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-22.
//

import UIKit
import SwiftUI

class ThirdViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupVCs()
		self.title = "UIKit View Controller"
		navigationItem.largeTitleDisplayMode = .never
	}
	
	func setupVCs() {
		let vc = UIHostingController(rootView: TableSwiftUIView())
		view.backgroundColor = .systemBackground
		view.addSubview(vStackView)
		
		let swiftUIView = vc.view!
		swiftUIView.translatesAutoresizingMaskIntoConstraints = false
		addChild(vc)
		
		navigateButton.addTarget(self, action: #selector(buttonTapped), for: .touchDown)

		[swiftUIView, navigateButton].forEach { vStackView.addArrangedSubview($0) }
		
		vStackView.anchor(
			top: view.safeAreaLayoutGuide.topAnchor,
			leading: view.safeAreaLayoutGuide.leadingAnchor,
			trailing: view.safeAreaLayoutGuide.trailingAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			padding: .init(top: 0, left: 12, bottom: 0, right: -12)
		)
	}
	
	@objc
	func buttonTapped() {
		let vc = UIHostingController(rootView: ChartView())
		navigationController?.pushViewController(vc, animated: true)
	}
	
	private var vStackView: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.distribution = .fillEqually
		view.spacing = 10
		return view
	}()
	
	
	private let navigateButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemOrange
		button.setTitle("UIKit Button\nNavigate to SwiftUI Chart", for: .normal)
		button.titleLabel?.numberOfLines = 0
		button.layer.cornerRadius = 10
		return button
	}()
	
}
