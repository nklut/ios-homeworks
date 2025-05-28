import UIKit

class ProfileHeaderView: UIView {
    
    private var picRadius = 150.0
    private var statusText = "Waiting for something..."
    
    // Add and setup Profile Avatar Image
    private lazy var avatarImageView: UIImageView = {
        // Declaration
        let view = UIImageView(image: UIImage(named: "cat"))
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = picRadius / 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        
        return view
    }()
    
    // Add and setup Full Name Label
    private lazy var fullNameLabel: UILabel = {
        // Declaration
        let view = UILabel()
        view.text = "Hipster Cat"
            
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        view.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        view.textColor = .black
            
        return view
        }()
    
    // Add and setup Profile Status Label
    private lazy var statusLabel: UILabel = {
        // Declaration
        let view = UILabel()
        view.text = statusText
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        view.textColor = .gray
        
        return view
    }()
    
    // Add and setup Status Text Field
    lazy var statusTextField: UITextField = {
       // Declaration
        let view = UITextField()
        view.placeholder = "Enter new status or title"

        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 12
        
        // Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 5.0, height: 0))
        view.leftView = padding
        view.leftViewMode = .always
        
        // Functions
        view.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return view
    }()
    
    // Add Set Status Button
    private lazy var setStatusButton: UIButton = {
        // Declaration
        let view = UIButton(type: .roundedRect)
        view.setTitle("Set status", for: .normal)
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(UIColor.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 4
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.7
        
        // Functions
        view.addTarget(self, action: #selector(didPressStatusButton), for: .touchUpInside)
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemGray6
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Moves Status Field text to Status Lable on button press
    @objc func didPressStatusButton() {
        statusLabel.text = statusText
        print(statusText)
    }
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text!
    }
    
    private func addSubviews() {
        avatarImageView.clipsToBounds = true
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(setStatusButton)
        addSubview(statusTextField)
    }
    
    // Setup Constraints for Profile Header view
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            // Avatar image view constraints
            avatarImageView.heightAnchor.constraint(equalToConstant: picRadius),
            avatarImageView.widthAnchor.constraint(equalToConstant: picRadius),
            avatarImageView.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            avatarImageView.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 16.0
            ),
            
            // Name label view constraints
            fullNameLabel.leadingAnchor.constraint(
                equalTo: avatarImageView.trailingAnchor,
                constant: 16.0
            ),
            fullNameLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 27.0
            ),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            // Status label view constraints
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusLabel.bottomAnchor.constraint(
                equalTo: statusTextField.topAnchor,
                constant: -16.0
            ),
            statusLabel.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 20),
            
            // Status text field view constraints
            statusTextField.bottomAnchor.constraint(
                equalTo: setStatusButton.topAnchor,
                constant: -16.0
            ),
            statusTextField.trailingAnchor.constraint(equalTo: setStatusButton.trailingAnchor),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Status Button view constraints
            setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            setStatusButton.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            setStatusButton.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16.0
            ),
            setStatusButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -16.0
            )
        ])
    }
}
