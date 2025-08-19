import UIKit

class FeedViewController: UIViewController {
    
    // Add coordinator
    weak var coordinator: FeedCoordinator?
    
    // Add button for Post 1
    private lazy var openPostButton1: UIButton = {
        // Declararion
        let view = CustomButton(title: "Open Post 1", titleColor: .white, forEvent: .touchUpInside, constraints: false)
        
        view.backgroundColor = .systemBlue
        view.eventOnTap = openPost1
        
        return view
    }()
    
    // Add button for Post 2
    private lazy var openPostButton2: UIButton = {
        // Declararion
        let view = CustomButton(title: "Open Post 2", titleColor: .white, forEvent: .touchUpInside, constraints: false)
        
        view.eventOnTap = openPost2
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private lazy var guessTextField: UITextField = {
        let view = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.placeholder = "Input your guess"
        view.textColor = .black
        view.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        view.leftView = paddingView
        view.leftViewMode = .always
        
        view.autocapitalizationType = .none
        view.backgroundColor = .systemGray6
        view.autocorrectionType = UITextAutocorrectionType.no
        view.keyboardType = UIKeyboardType.default
        view.returnKeyType = UIReturnKeyType.done
        view.clearButtonMode = UITextField.ViewMode.whileEditing
        
        return view
    }()
    
    private lazy var chekGuessButton: CustomButton = {
        
        let view = CustomButton(title: "Check Guess", titleColor: .white, forEvent: .touchUpInside, constraints: false)
        view.backgroundColor = .systemBlue
        view.eventOnTap = checkGuessTapped
        
        return view
        
    }()
    
    private lazy var resultLabel: UILabel = {
        let view = UILabel()
        
        view.text = "Make your guess Above"
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.textColor = .black
        view.backgroundColor = .white
        
        return view
    } ()
    
    // Add stack view for an Open Post buttons
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        
        // Setup
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        
        // Design
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 10.0
        view.axis = .vertical
        
        // Add buttons
        view.addArrangedSubview(self.openPostButton1)
        view.addArrangedSubview(self.openPostButton2)
        view.addArrangedSubview(self.guessTextField)
        view.addArrangedSubview(self.chekGuessButton)
        view.addArrangedSubview(self.resultLabel)
        
        return view
    }()
    
    override func viewDidLoad() {
        // Setup main view
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Feed"
        
        // Add Stacked buttons to Feed View
        view.addSubview(stackView)
        
        // Positioning
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
    }
    
    // MAke a guess on button tap and show result as alert msg
    @objc func checkGuessTapped() {
        var resultMessage: String
        let feed = FeedViewModel()
        
        if feed.check(guessTextField.text!) == .correct {
            resultMessage = "Correct"
            guessTextField.text = ""
            resultLabel.text = resultMessage
            resultLabel.textColor = .systemGreen
        } else {
            resultMessage = "Wrong"
            guessTextField.text = ""
            resultLabel.text = resultMessage
            resultLabel.textColor = .systemRed
        }
        
        let alert = UIAlertController(title: "Guess results", message: resultMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: wrongLoginAlert))
        self.present(alert, animated: true, completion: nil)
        func wrongLoginAlert(action: UIAlertAction) {}
        
    }
    
    // Open post 1 for button 1
    @objc func openPost1() {
        let currentPost = Post(title: "Post 1")
        let pvc = PostViewController(post: currentPost)
        self.navigationController?.pushViewController(pvc, animated: true)
    }
    
    // Open post 2 for button 2
    @objc func openPost2() {
        //        let currentPost = Post(title: "Post 2")
        //        let pvc = PostViewController(post: currentPost)
        //        self.navigationController?.pushViewController(pvc, animated: true)
    }
}
