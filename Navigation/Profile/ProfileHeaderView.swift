import UIKit

class ProfileHeaderView: UIView {
        
    var profilePic: UIImageView
    var profileName: UILabel
    //var logo: UIView

    
    override init(frame: CGRect) {
        
        profileName = UILabel()
        profilePic = UIImageView()
        super.init(frame: frame)

        // Profile picture seup
        profilePic = UIImageView(image: UIImage(named: "cat"))
        profilePic.frame = CGRect(x: 16.0, y: 16.0, width: 150, height: 150)
        profilePic.layer.cornerRadius = 70.0
        profilePic.layer.borderColor = UIColor.white.cgColor
        profilePic.layer.borderWidth = 3
        
        // Profile Name
        profileName.frame = CGRect(x: 200, y: 27, width: 100, height: 18)
        profileName.text = "Hipster Cat"
        profileName.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        profileName.textColor = .black
        
        
        
        profilePic.clipsToBounds = true
       // profileName.layer.masksToBounds = true
        
        
        
        
        addSubview(profilePic)
        addSubview(profileName)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
}

