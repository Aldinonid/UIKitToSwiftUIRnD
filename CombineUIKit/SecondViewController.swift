//
//  SecondViewController.swift
//  CombineUIKit
//
//  Created by Aldino Efendi on 2023-06-15.
//

import UIKit
import Combine

class SecondViewController: UIViewController {
	
	@IBOutlet var termsSwitch: UIStackView!
	@IBOutlet var privacySwitch: UISwitch!
	@IBOutlet var nameField: UITextField!
	@IBOutlet var submitButton: UIButton!
	
	// Define Publisher
	@Published private var acceptedTerms: Bool = false
	@Published private var acceptedPrivacy: Bool = false
	@Published private var name: String = ""
	
	// Define combine cancellable
	private var stream = Set<AnyCancellable>()
	
	private var validToSubmit: AnyPublisher<Bool, Never> {
		Publishers.CombineLatest3($acceptedTerms, $acceptedPrivacy, $name)
			.map { terms, privacy, name in
				terms && privacy && !name.isEmpty
			}
			.eraseToAnyPublisher()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		nameField.delegate = self

		validToSubmit
			.sink { _ in
				
			} receiveValue: { [weak self] bool in
				self?.submitButton.isEnabled = bool
			}
			.store(in: &stream)

	}
	
	@IBAction func acceptTerms(_ sender: UISwitch) {
		acceptedTerms = sender.isOn
	}
	
	@IBAction func acceptPrivacy(_ sender: UISwitch) {
		acceptedPrivacy = sender.isOn
	}
	
	@IBAction func nameChanged(_ sender: UITextField) {
		name = sender.text ?? ""
	}
	
	@IBAction func submitAction(_ sender: UIButton) {
		print("foo - Submit: \(name)")
	}
}

extension SecondViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
