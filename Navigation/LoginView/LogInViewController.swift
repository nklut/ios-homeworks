import UIKit

class LogInViewController: UIViewController {
    
    // Login screen Logo
    private lazy var logInLogo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo"))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Login Screen USername Field
    private lazy var userNameField: UITextField = {
        let view = UITextField()
        view.placeholder = "E-mail or phone"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        
        // Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 0))
        view.leftView = padding
        view.leftViewMode = .always
        
        view.delegate = self
        
        return view
    }()
    
    // Login Screen Pasword Field
    private lazy var passwordField: UITextField = { [unowned self] in
        let view = UITextField()
        view.placeholder = "Password"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.isSecureTextEntry = true
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        
        // Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10.0, height: 0))
        view.leftView = padding
        view.leftViewMode = .always
        
        view.delegate = self
        
        return view
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    var loginDelegate: LoginViewControllerDelegate = LoginInspector()
    
    // Scroll view for position adaptation when keyboard appears
    private lazy var userDataScrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        
        //Border style
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        
        return view
    }()
    
    // Login Screen Log-in button
    private lazy var logInButton: UIButton = {
        let view = CustomButton(frame: CGRect(), title: "Log In", titleColor: .white, for: .touchUpInside, constraints: false)
    
        view.layer.cornerRadius = 10.0
        view.setBackgroundImage(UIImage(named: "logInButton"), for: .normal)
        view.eventOnTap = didTapButton
        
        return view
    }()
    
    // Scroll view for position adaptation when keyboard appears
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // Main content view for login subviews
    private lazy var contentView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide Tab bar, when not logged in
        self.tabBarController?.tabBar.isHidden = true
        
        // Add and setup subviews
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
            
        setupConstraints()
        addContentSubviews()
        setupSubviewsConstraints()
    }
    
    // Keyboard appears handler
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupKeyboardObservers()
    }
    
    // Keyboard disappears handler
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    // On login button press, clear fields and open Profile screen
    @objc func didTapButton() -> Void {
        
        let userLogin = userNameField.text ?? "_"
        let userPass = passwordField.text ?? "_"
        let isCorrect = loginDelegate.check(userLogin: userLogin, userPass: userPass)
        
        #if DEBUG
            let user = TestUserService().chekUserLogin(userLogin)
        #else
            let user = CurentUserService().chekUserLogin(userLogin)
        #endif
       
        if isCorrect {
            let pvc = ProfileViewController(user: user!)
            self.navigationController?.pushViewController(pvc, animated: true)
        } else {
            
            userNameField.text = ""
            passwordField.text = ""
            
            #if DEBUG
                let alertMessage = "DEBUG MODE. Login: 123, Pass: 123"
            #else
                let alertMessage = "Please try again"
            #endif
            
            let alert = UIAlertController(
                title: "Wrong Login or Password",
                message: alertMessage,
                preferredStyle: .alert
            )
            
            func wrongLoginAlert(action: UIAlertAction) {}
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: wrongLoginAlert))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // move text Fields higher on keyboard appearance
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?
            .cgRectValue.height
        
        scrollView.contentInset.bottom = keyboardHeight ?? 0.0
    }
    
    // move text fields back on keyboard disappearance
    @objc func willHideKeyboard(_ notification:NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    //Setup keyboard observers
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
    
    //Setup remove keyboard observers
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // Add subviews to content view
    private func addContentSubviews() {
        
        // Add Logo to main content View
        contentView.addSubview(logInLogo)
        
        // Add User Data Text Fields
        userDataScrollView.addSubview(userNameField)
        userDataScrollView.addSubview(separatorView)
        userDataScrollView.addSubview(passwordField)
        
        // Add User Data scroll view and Log-in Button to mai content view
        contentView.addSubview(userDataScrollView)
        contentView.addSubview(logInButton)
    }
    
    // Setup subviews positions for elements inside scrollview
    private func setupSubviewsConstraints() {
        
        NSLayoutConstraint.activate([
            // Setup Logo position
            logInLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInLogo.heightAnchor.constraint(equalToConstant: 100),
            logInLogo.widthAnchor.constraint(equalToConstant: 100),
            logInLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),

            // Setup User Data scroll view position
            userDataScrollView.topAnchor.constraint(equalTo: logInLogo.bottomAnchor, constant: 120),
            userDataScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userDataScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            userDataScrollView.heightAnchor.constraint(equalToConstant: 100.5),
            
            // Setup User Data content view position
            userNameField.topAnchor.constraint(equalTo: userDataScrollView.topAnchor),
            userNameField.leadingAnchor.constraint(equalTo: userDataScrollView.leadingAnchor),
            userNameField.heightAnchor.constraint(equalToConstant: 50),
            userNameField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            
            // Setup text fields separator Line
            separatorView.topAnchor.constraint(equalTo: userNameField.bottomAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            separatorView.leadingAnchor.constraint(equalTo: userDataScrollView.leadingAnchor),
            separatorView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            // Setup Password position
            passwordField.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            passwordField.leadingAnchor.constraint(equalTo: userDataScrollView.leadingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            passwordField.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            
            // Setup Log-in button position
            logInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // Setup Main views position
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        // Setup scroll view position
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            // Setup content view position
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

// Responder for textfield text input
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
