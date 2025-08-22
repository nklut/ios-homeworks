import UIKit

class InfoViewController: UIViewController {
    
    // Show allert Button setup
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Delete post", for: .normal)
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var jsonLabel: UILabel = {
        let view = UILabel()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        view.textColor = .black
        view.text = "Push the button to get info"
        
        return view
    }()
    
    private lazy var buttonTodos: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Get Todos title", for: .normal)
        view.addTarget(self, action: #selector(didTapTodos), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var buttonPlanets: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Get Planet Orbital period", for: .normal)
        view.addTarget(self, action: #selector(didTapPlanets), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var buttonCitizens: UIButton = {
        let view = UIButton(type: .roundedRect)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Get Planet Citizens", for: .normal)
        view.addTarget(self, action: #selector(didTapCitizens), for: .touchUpInside)
        
        return view
    }()
    
    @objc func didTapTodos() {
        NetworkManager().requestTodos(from: .toDoListJSON) { result in
            DispatchQueue.main.async {
                self.jsonLabel.text = "Title is: \(result)"
            }
        }
    }
    
    @objc func didTapPlanets() {
        NetworkManager().requestPlanets(from: .planetsJSON) { result in
            DispatchQueue.main.async {
                self.jsonLabel.text = "Orbital period is: \(result.orbital_period)"
            }
        }
    }
    
    @objc func didTapCitizens() {
        jsonLabel.text = "Citizens"
    }
    
    // Show Alert on button press
    @objc func didPressButton() {
        // Create Alert object
        let alert = UIAlertController(
            title: "Delete",
            message: "If you delete this post, it will no longer be available",
            preferredStyle: .alert
        )
        
        // Print used action to console
        func consolePrint(action: UIAlertAction) {
            print(action.title!)
        }
        
        // Set couple alert Actions
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: consolePrint))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: consolePrint))
        
        // Show Alert
        self.present(alert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Info"
        
        // Add and setup button
        view.addSubview(button)
        view.addSubview(jsonLabel)
        view.addSubview(buttonTodos)
        view.addSubview(buttonPlanets)
        view.addSubview(buttonCitizens)
        
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            jsonLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            jsonLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 30),
            jsonLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -30),
            jsonLabel.heightAnchor.constraint(equalToConstant: 50),
            
            buttonTodos.topAnchor.constraint(equalTo: jsonLabel.bottomAnchor, constant: 10),
            buttonTodos.leadingAnchor.constraint(equalTo: jsonLabel.leadingAnchor),
            buttonTodos.trailingAnchor.constraint(equalTo: jsonLabel.trailingAnchor),
            
            buttonPlanets.topAnchor.constraint(equalTo: buttonTodos.bottomAnchor, constant: 10),
            buttonPlanets.leadingAnchor.constraint(equalTo: jsonLabel.leadingAnchor),
            buttonPlanets.trailingAnchor.constraint(equalTo: jsonLabel.trailingAnchor),
            
            buttonCitizens.topAnchor.constraint(equalTo: buttonPlanets.bottomAnchor, constant: 10),
            buttonCitizens.leadingAnchor.constraint(equalTo: jsonLabel.leadingAnchor),
            buttonCitizens.trailingAnchor.constraint(equalTo: jsonLabel.trailingAnchor),
            
            button.topAnchor.constraint(equalTo: buttonCitizens.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
        
    }

}
