import UIKit

class LogInViewController: UIViewController {
    
    private lazy var logInLogo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var userNameField: UITextField = { [unowned self] in
        let view = UITextField()
        view.placeholder = "E-mail or phone"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        view.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        view.delegate = self
        
        // Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 0))
        view.leftView = padding
        view.leftViewMode = .always
        
        return view
    }()
    
    private lazy var passwordField: UITextField = { [unowned self] in
        let view = UITextField()
        view.placeholder = "Password"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.isSecureTextEntry = true
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        view.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        view.delegate = self
        
        // Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 0))
        view.leftView = padding
        view.leftViewMode = .always
        
        return view
    }()
    
    private lazy var logInButton: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.setTitle("Log In", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setBackgroundImage(UIImage(named: "logInButton"), for: .normal)
        
        view.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tabBarController?.tabBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(logInLogo)
        scrollView.addSubview(userNameField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(logInButton)
        
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    @objc func didTapButton() {
        let pvc = ProfileViewController()
        passwordField.text = ""
        userNameField.text = ""
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification:NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
    
            logInLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInLogo.heightAnchor.constraint(equalToConstant: 100),
            logInLogo.widthAnchor.constraint(equalToConstant: 100),
            logInLogo.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 120),
            
            userNameField.topAnchor.constraint(equalTo: logInLogo.bottomAnchor, constant: 120),
            userNameField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            userNameField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            userNameField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: userNameField.bottomAnchor),
            passwordField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16.0)
            
        ])
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
