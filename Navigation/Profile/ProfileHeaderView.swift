import UIKit

class ProfileHeaderView: UIView {
        
    var profilePic: UIImageView
    var profileName: UILabel
    var profileStatus: UILabel
    var statusButton: UIButton
    var statusTextField: UITextField
    
    let baseWidth = 150.0
    let baseHeight = 150.0
    
    private var statusText: String
    
    @objc func didPressButton() {
        if self.statusButton.backgroundColor == UIColor.systemBlue{
            self.statusButton.backgroundColor = UIColor.systemRed
        } else {
            self.statusButton.backgroundColor = UIColor.systemBlue
        }
        
        profileStatus.text = statusText
        
    }
  
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text!
    }
       
    override init(frame: CGRect) {
        
        profilePic = UIImageView()
        profileName = UILabel()
        profileStatus = UILabel()
        statusButton = UIButton()
        statusTextField = UITextField()
        statusText = "Waiting for something..."
        
        super.init(frame: frame)

        // Profile picture
        profilePic = UIImageView(image: UIImage(named: "cat"))
        profilePic.frame = CGRect(
            x: 16.0,
            y: 16.0,
            width: baseWidth,
            height: baseHeight
        )
        profilePic.layer.cornerRadius = baseHeight / 2
        profilePic.layer.borderColor = UIColor.white.cgColor
        profilePic.layer.borderWidth = 3
        
        // Profile Name
        profileName.frame = CGRect(
            x: 16.0 + baseWidth + 16.0,
            y: 27,
            width: 100,
            height: 18
        )
        profileName.text = "Hipster Cat"
        profileStatus.sizeToFit()
        profileName.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        profileName.textColor = .black
        
        // Profile Status
        profileStatus.frame = CGRect(
            x: 16.0 + baseWidth + 16.0,
            y: 16.0 + baseWidth + 16.0 - 34.0 - 14.0,
            width: 100,
            height: 14
        )
        profileStatus.text = statusText
        profileStatus.sizeToFit()
        profileStatus.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        profileStatus.textColor = .gray
        
        // Status text
        statusTextField.frame = CGRect(
            x: 16.0 + baseWidth + 16.0,
            y: 154,
            width: 150,
            height: 40
        )
        //statusText.sizeToFit()
        statusTextField.placeholder = " Enter text"
        statusTextField.backgroundColor = .white
        statusTextField.textColor = .black
        statusTextField.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.regular)
        
        
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.layer.cornerRadius = 12
        
               
        // Profile Status Button
        statusButton.setTitle("Set status", for: .normal)
        statusButton.backgroundColor = .systemBlue
        statusButton.frame = CGRect(
            x: 16.0,
            y: 16.0 + baseWidth + 32.0,
            width: 364,
            height: 50
        )
        statusButton.layer.cornerRadius = 4
        statusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        statusButton.layer.shadowRadius = 4
        statusButton.layer.shadowColor = UIColor.black.cgColor
        statusButton.layer.shadowOpacity = 0.7
        
        statusButton.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
      
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

