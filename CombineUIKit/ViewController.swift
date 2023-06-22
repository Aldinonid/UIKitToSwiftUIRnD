//
//  ViewController.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-15.
//

import UIKit
import SwiftUI
import Combine

struct BlogPost {
	let title: String
}

extension Notification.Name {
	static let newBlogPost = Notification.Name("newPost")
}

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		
		publishButton.addTarget(self, action: #selector(publishButtonTapped), for: .touchUpInside)
		navigateButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
		navigateThirdButton.addTarget(self, action: #selector(nextThirdButtonTapped), for: .touchUpInside)
		
		let publisher = NotificationCenter.Publisher(center: .default, name: .newBlogPost)
			.map { notification -> String? in
				(notification.object as? BlogPost)?.title ?? ""
			}
		
		let subscriber = Subscribers.Assign(object: subscriberLabel, keyPath: \.text)
		publisher.subscribe(subscriber)
	}
	
	func setupView() {
		view.backgroundColor = .systemBackground
		view.addSubview(vStackView)
		[hStackView, subscriberLabel, navigateButton, navigateThirdButton].forEach { vStackView.addArrangedSubview($0) }
		[textField, publishButton].forEach { hStackView.addArrangedSubview($0) }
		
		vStackView.anchor(
			top: view.safeAreaLayoutGuide.topAnchor,
			leading: view.safeAreaLayoutGuide.leadingAnchor,
			trailing: view.safeAreaLayoutGuide.trailingAnchor,
			bottom: view.safeAreaLayoutGuide.bottomAnchor,
			padding: .init(top: 0, left: 12, bottom: 0, right: -12)
		)
	}
	
	@objc
	func publishButtonTapped() {
		let title = textField.text ?? "Coming soon"
		let blogPost = BlogPost(title: title)
		NotificationCenter.default.post(name: .newBlogPost, object: blogPost)
	}
	
	@objc
	func nextButtonTapped() {
		let sb = UIStoryboard(name: "Second", bundle: nil)
		let vc =	sb.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
		navigationController?.pushViewController(vc, animated: true)
//		navigationToSecondViewController(storyboardName: "Second", to: SecondViewController())
	}
	
	@objc
	func nextThirdButtonTapped() {
		let thirdVC = UIHostingController(rootView: ThridView())
		navigationController?.pushViewController(thirdVC, animated: true)
	}
	
	func navigationToSecondViewController(storyboardName sbName: String, to navigation: UIViewController) {
//		let sb = UIStoryboard(name: sbName, bundle: nil)
//		let vc =	sb.instantiateViewController(identifier: String(describing: navigation.self)) as! navigation
//		self.navigationController?.pushViewController(navigation, animated: true)
	}
	
	private var vStackView: UIStackView = {
		let view = UIStackView()
		view.axis = .vertical
		view.distribution = .fillEqually
		view.spacing = 10
		return view
	}()
	
	private var hStackView: UIStackView = {
		let view = UIStackView()
		view.axis = .horizontal
		view.distribution = .fillEqually
		view.spacing = 10
		return view
	}()
	
	private let textField: UITextField = {
		let view = UITextField()
		view.backgroundColor = .lightGray
		view.placeholder = "Input a text"
		view.keyboardType = .default
		view.layer.cornerRadius = 10
		return view
	}()
	
	private let publishButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemBlue
		button.setTitle("Publish", for: .normal)
		button.layer.cornerRadius = 10
		return button
	}()
	
	private let navigateButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemOrange
		button.setTitle("Next", for: .normal)
		button.layer.cornerRadius = 10
		return button
	}()
	
	private let subscriberLabel: UILabel = {
		let view = UILabel()
		view.text = "Subscriber"
		return view
	}()
	
	private let navigateThirdButton: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemPink
		button.setTitle("Navigate to Third View", for: .normal)
		button.layer.cornerRadius = 10
		return button
	}()

}

extension UIView {
	func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		
		if let top = top {
			topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
		}
		if let leading = leading {
			leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
		}
		if let trailing = trailing {
			trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
		}
		if let bottom = bottom {
			bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
		}
		
		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}
		
		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
	}
}
