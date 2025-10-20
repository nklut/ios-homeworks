import UIKit

class CustomButton: UIButton {
    
    private var title: String
    private var titleColor: UIColor
    private var eventType: UIControl.Event
    var eventOnTap: (() -> Void)?
    private var isConstraintsDesign: Bool
    
    init(title: String, titleColor: UIColor, forEvent eventType: UIControl.Event, constraints isConstraintsDesign: Bool) {
        self.title = title
        self.titleColor = titleColor
        self.eventType = eventType
        self.isConstraintsDesign = isConstraintsDesign

        super.init(frame: .zero)
        
        self.setTitleColor(self.titleColor, for: .normal)
        self.setTitle(self.title, for: .normal)
        
        if !isConstraintsDesign {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        self.addTarget(self, action: #selector(buttonTapped), for: self.eventType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped() {
        eventOnTap?()
    }
    
}
