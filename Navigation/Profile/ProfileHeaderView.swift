import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private var picRadius = 150.0
    private var statusText = "Waiting for something..."

    
    private lazy var closeButton: UIButton = {
        let view = UIButton(type: .close)
        // view.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        // close Button constraints
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        // Avatar image view background constraints
        avatarImageBackground.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.equalTo(picRadius)
            make.height.equalTo(picRadius)
        }
        
        // Avatar image view constraints
        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(avatarImageBackground)
            make.top.equalTo(avatarImageBackground)
            make.width.equalTo(picRadius)
            make.height.equalTo(picRadius)
        }
        
        // Name label view constraints
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(safeAreaLayoutGuide).offset(27)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(18)
        }
        
        // Status label view constraints
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(fullNameLabel)
            make.top.equalTo(safeAreaLayoutGuide).offset(110)
            make.trailing.equalTo(fullNameLabel)
            make.height.equalTo(14)
        }
        
        // Status text field view constraints
        statusTextField.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(statusLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(16)
            make.trailing.equalTo(statusLabel)
            make.height.equalTo(40)
        }
        
        // Status Button view constraints
        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.trailing.equalTo(fullNameLabel)
            make.height.equalTo(50)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
        }
    }
}
