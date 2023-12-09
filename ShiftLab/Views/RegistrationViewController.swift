//
//  ViewController.swift
//  ShiftLab
//
//  Created by Сергей Дашко on 09.12.2023.
//

import UIKit

class RegistrationViewController: UIViewController {

    // MARK: - Properties

    private var activeTextField: UITextField?
    private let viewModel = RegistrationViewModel()

    // MARK: - UI Elements

    private lazy var nameLabel: UILabel = makeLabel(withText: "Имя:")
    private lazy var nameTextField: UITextField = makeTextField(withPlaceholder: "Введите имя")
    private lazy var surnameLabel: UILabel = makeLabel(withText: "Фамилия:")
    private lazy var surnameTextField: UITextField = makeTextField(withPlaceholder: "Введите фамилию")
    private lazy var dobLabel: UILabel = makeLabel(withText: "Дата рождения:")
    private lazy var dobTextField: UITextField = {
        let textField = makeTextField(withPlaceholder: "Выберите дату рождения")
        textField.inputView = datePicker
        return textField
    }()
    private lazy var passwordLabel: UILabel = makeLabel(withText: "Пароль:")
    private lazy var passwordTextField: UITextField = makeTextField(withPlaceholder: "Введите пароль")
    private lazy var secondPasswordTextField: UITextField = makeTextField(withPlaceholder: "Повторите пароль")
    private lazy var registrationButton: UIButton = makeButton(withTitle: "Зарегистрироваться")
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var doneGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doneGestureAction))

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return datePicker
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(doneGesture)
        setupUI()
        bindViewModel()
        registrationButton.isEnabled = false
        setupKeyboardObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - UI Setup

    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(surnameLabel)
        view.addSubview(surnameTextField)
        view.addSubview(dobLabel)
        view.addSubview(dobTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(secondPasswordTextField)
        view.addSubview(registrationButton)
        view.addSubview(errorLabel)

        nameTextField.delegate = self
        surnameTextField.delegate = self
        dobTextField.delegate = self
        passwordTextField.delegate = self
        secondPasswordTextField.delegate = self

        // Constraints setup
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 175),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            surnameLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            surnameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            surnameTextField.topAnchor.constraint(equalTo: surnameLabel.bottomAnchor, constant: 8),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            surnameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            dobLabel.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 20),
            dobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            dobTextField.topAnchor.constraint(equalTo: dobLabel.bottomAnchor, constant: 8),
            dobTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dobTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dobTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordLabel.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 20),
            passwordLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            secondPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            secondPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            secondPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            secondPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            registrationButton.topAnchor.constraint(equalTo: secondPasswordTextField.bottomAnchor, constant: 50),
            registrationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrationButton.widthAnchor.constraint(equalToConstant: 250),
            registrationButton.heightAnchor.constraint(equalToConstant: 44),
            
            errorLabel.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 20),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            errorLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }

    // MARK: - UI Element Factories

    private func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private func makeTextField(withPlaceholder placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }

    private func makeButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(registrationButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    // MARK: - User Defaults
    
    func saveUserDataToUserDefaults(user: UserData) {
        let userDefaults = UserDefaults.standard
        let userData = try? JSONEncoder().encode(user)
        userDefaults.setValue(userData, forKey: "userDataKey")
    }

    // MARK: - ViewModel Binding

    private func bindViewModel() {
        viewModel.statusText.bind { [weak self] (statusText) in
            DispatchQueue.main.async {
                self?.errorLabel.text = statusText
            }
        }
    }

    // MARK: - ViewModel Interaction

    @objc private func registrationButtonAction() {
        viewModel.userButtonPressed(
            name: nameTextField.text ?? "",
            surname: surnameTextField.text ?? "",
            date: dobTextField.text ?? "",
            password: passwordTextField.text ?? "",
            secondPassword: secondPasswordTextField.text ?? "")
    }

    // MARK: - TextField and Keyboard Handling

    @objc private func textFieldDidChange() {
        let allFieldsFilled = ![nameTextField, surnameTextField, dobTextField, passwordTextField, secondPasswordTextField].contains { $0.text?.isEmpty ?? true }
        registrationButton.isEnabled = allFieldsFilled
    }

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardFrame.cgRectValue.height
        self.view.frame.origin.y = -keyboardHeight
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    // MARK: - Date Picker Handling

    @objc private func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobTextField.text = dateFormatter.string(from: datePicker.date)
    }

    // MARK: - Gesture Recognizer Handling

    @objc private func doneGestureAction() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
}
