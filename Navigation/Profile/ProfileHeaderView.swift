import UIKit

class ProfileHeaderView: UIView {
    
    private var picRadius = 150.0
    private var statusText = "Waiting for something..."
    
    private lazy var closeButton: UIButton = {
        let view = UIButton(type: .close)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .white
        view.alpha = 0
        
        view.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        return view
    }()

    // Add and setup Profile Avatar Image
    private lazy var avatarImageView: UIImageView = {
        // Declaration
        let view = UIImageView(image: UIImage(named: "cat"))
        
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = picRadius / 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 3
        
        // Add gesture on tap
        let tapRoot = UITapGestureRecognizer(
            target: self,
            action: #selector(didTapAvatar)
        )
        
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapRoot)
        
        return view
    }()
    
    // Image background
    private lazy var avatarImageBackground: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        view.backgroundColor = .systemGray6
        
        return view
    }()

    // Add and setup Full Name Label
    private lazy var fullNameLabel: UILabel = {
        // Declaration
        let view = UILabel()
        view.text = "Hipster Cat"
            
        // Design
        view.translatesAutoresizingMaskIntoConstraints = false
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
    }
    
    // Changes status Text based on text field input
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text!
    }
    
    // Animation on avatar image Tap
    @objc func didTapAvatar() {
        launchAnimation()
    }
    
    // Animation on close button Tap
    @objc func didTapCloseButton() {
        launchReversedAnimation()
    }
    
    // Avatar image animation
    private func launchAnimation() {
       
        // Get screen center position
        let midX = UIScreen.main.bounds.midX
        let tabH = self.inputViewController?.tabBarController?.tabBar.frame.size.height ?? 83
        let midY = UIScreen.main.bounds.midY - tabH
        
        // Get size scale multiplier
        let screenW = UIScreen.main.bounds.width
        let picScale = screenW / picRadius
    
        let animator = UIViewPropertyAnimator(
            duration: 0.5,
            curve: .linear
        ) {
            // 1 Move to center of the screen
            self.avatarImageView.center = CGPoint(x: midX, y: midY)
            self.avatarImageBackground.center = CGPoint(x: midX, y: midY)
            
            // 2 Change size and corner radius
            self.avatarImageView.layer.borderWidth = 0
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarImageView.transform = CGAffineTransform(
                scaleX: picScale,
                y: picScale
            )
            self.avatarImageBackground.transform = CGAffineTransform(
                scaleX: picScale,
                y: picScale * 3
            )
            
            // 3 Change background opacity
            self.avatarImageBackground.alpha = 0.95
            self.closeButton.alpha = 1
        }
        
        animator.startAnimation(afterDelay: 0.5)
    }
    
    // Reverse Avatar image animation
    private func launchReversedAnimation() {
        let originP = 16 + picRadius / 2
        
        let animator = UIViewPropertyAnimator(
            duration: 0.5,
            curve: .linear
        ) {
            // 1 Move to origin position
            self.avatarImageView.center = CGPoint(x: originP, y: originP)
            self.avatarImageBackground.center = CGPoint(x: originP, y: originP)
            
            // 2 Change size and corner radius to original values
            self.avatarImageView.layer.borderWidth = 3
            self.avatarImageView.layer.cornerRadius = self.picRadius / 2
            self.avatarImageView.transform = CGAffineTransform(
                scaleX: 1.0,
                y: 1.0
            )
            self.avatarImageBackground.transform = CGAffineTransform(
                scaleX: 1.0,
                y: 1.0
            )
            
            // 3 Change background opacity to original values
            self.avatarImageBackground.alpha = 0
            self.closeButton.alpha = 0
        }
        
        animator.startAnimation(afterDelay: 0.5)
    }
    
    private func addSubviews() {
        avatarImageView.clipsToBounds = true
        addSubview(avatarImageView)
        insertSubview(avatarImageBackground, belowSubview: avatarImageView)
        insertSubview(closeButton, belowSubview: avatarImageView)
        insertSubview(fullNameLabel, belowSubview: avatarImageBackground)
        insertSubview(statusLabel, belowSubview: avatarImageBackground)
        insertSubview(statusTextField, belowSubview: avatarImageBackground)
        insertSubview(setStatusButton, belowSubview: avatarImageBackground)
    }
    
    // Setup Constraints for Profile Header view
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([

            // Avatar image view background constraints
            avatarImageBackground.heightAnchor.constraint(equalToConstant: picRadius),
            avatarImageBackground.widthAnchor.constraint(equalToConstant: picRadius),
            avatarImageBackground.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 16.0
            ),
            avatarImageBackground.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 16.0
            ),
            
            // Avatar image view constraints
            avatarImageView.heightAnchor.constraint(equalToConstant: picRadius),
            avatarImageView.widthAnchor.constraint(equalToConstant: picRadius),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarImageBackground.leadingAnchor),
            avatarImageView.topAnchor.constraint(equalTo: avatarImageBackground.topAnchor),
            
            // close Button constraints
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 16),
            closeButton.widthAnchor.constraint(equalToConstant: 16),

            // Name label view constraints
            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            fullNameLabel.topAnchor.constraint(
                equalTo: safeAreaLayoutGuide.topAnchor,
                constant: 27.0
            ),
            fullNameLabel.heightAnchor.constraint(equalToConstant: 18),
            fullNameLabel.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -16),

            // Status label view constraints
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 110),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusLabel.heightAnchor.constraint(equalToConstant: 14),

            // Status text field view constraints
            statusTextField.trailingAnchor.constraint(equalTo: statusLabel.trailingAnchor),
            statusTextField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            // Status Button view constraints
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50.0),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            setStatusButton.bottomAnchor.constraint(
                equalTo: safeAreaLayoutGuide.bottomAnchor,
                constant: -16.0
            )
        ])
    }
}
