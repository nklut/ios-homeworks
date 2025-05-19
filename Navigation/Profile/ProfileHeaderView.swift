import UIKit

class ProfileHeaderView: UIView {
    
    // Initial Status Field text and Profile Picture size
    var statusText = "Waiting for something..."
    private var picRadius = 150.0
   
    // Add and setup Profile Picture
    private lazy var profilePic: UIImageView = {
        // Declaration and Position
        let profilePic = UIImageView(image: UIImage(named: "cat"))
        profilePic.frame = CGRect(
            x: 16.0,
            y: 16.0,
            width: picRadius,
            height: picRadius
        )
        
        // Design
        profilePic.layer.cornerRadius = picRadius / 2
        profilePic.layer.borderColor = UIColor.white.cgColor
        profilePic.layer.borderWidth = 3
        
        return profilePic
    }()
    
    // Add and setup Profile Name
    private lazy var profileName: UILabel = {
        // Declaration and Position
        let profileName = UILabel()
        profileName.frame = CGRect(
            x: 16.0 + picRadius + 16.0,
            y: 27,
            width: 100,
            height: 18
        )
        profileName.text = "Hipster Cat"
        
        // Design
        profileStatus.sizeToFit()
        profileName.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        profileName.textColor = .black
        
        return profileName
    }()
    
    // Add and setup Profile Status Text
    lazy var profileStatus: UILabel = {
        // Declaration and Position
        let profileStatus = UILabel()
        profileStatus.frame = CGRect(
            x: 16.0 + picRadius + 16.0,
            y: 16.0 + picRadius + 16.0 - 34.0 - 14.0,
            width: 100,
            height: 14
        )
        profileStatus.text = statusText
        
        // Design
        profileStatus.sizeToFit()
        profileStatus.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        profileStatus.textColor = .gray
        
        return profileStatus
    }()
    
    // Add and setup Profile Status Field
    lazy var statusTextField: UITextField = {
       // Declaration and Position
        let statusTextField = UITextField()
        statusTextField.frame = CGRect(
            x: 16.0 + picRadius + 16.0,
            y: 154,
            width: 200,
            height: 40
        )
        statusTextField.placeholder = " Enter text..."

        // Design
        statusTextField.backgroundColor = .white
        statusTextField.textColor = .black
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        
        // Padding
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 5.0, height: 0))
        statusTextField.leftView = padding
        statusTextField.leftViewMode = .always
        
        // Functions
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        
        return statusTextField
    }()
    
    // Add profile status text change button
    lazy var statusButton: UIButton = {
        // Declaration and Position
        let statusButton = UIButton(type: .roundedRect)
        statusButton.setTitle("Set status", for: .normal)
        statusButton.frame = CGRect(
            x: 16.0,
            y: 16.0 + picRadius + 32.0,
            width: 364.0,
            height: 50.0
        )
        
        // Design
        statusButton.setTitleColor(UIColor.white, for: .normal)
        statusButton.backgroundColor = .systemBlue
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        
        // Functions
        statusButton.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        
        return statusButton
    }()
  
    // Moves Status Field text to Status Lable on button press
    @objc func didPressButton() {
        profileStatus.text = statusText
        print(statusText)
    }
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text!
    }
    
    // INIT
    override init(frame: CGRect) {
        super.init(frame: frame)

        // Subviews setup
        profilePic.clipsToBounds = true
        addSubview(profilePic)
        addSubview(profileName)
        addSubview(profileStatus)
        addSubview(statusButton)
        addSubview(statusTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
