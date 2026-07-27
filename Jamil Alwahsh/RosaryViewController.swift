import UIKit

class RosaryViewController: UIViewController {

    // MARK: - Properties
    private var counter = 0
    private let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
    private let successFeedback = UINotificationFeedbackGenerator()
    private let counterKey = "rosaryCounter"

    // MARK: - UI Components
    private let backgroundGradientLayer = CAGradientLayer()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "مسبحة الاستغفار"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 80, weight: .bold)
        label.textColor = .cyan
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tapButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        button.layer.cornerRadius = 100
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.2).cgColor
        button.addTarget(self, action: #selector(didTap), for: .touchDown)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
        button.setImage(UIImage(systemName: "arrow.counterclockwise", withConfiguration: config), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(didReset), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
        setupViews()
        setupConstraints()
        
        counter = UserDefaults.standard.integer(forKey: counterKey)
        counterLabel.text = "\(counter)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradientLayer.frame = view.bounds
    }
    
    // MARK: - Setup
    private func setupBackground() {
        backgroundGradientLayer.colors = [
            UIColor(red: 0.03, green: 0.06, blue: 0.12, alpha: 1.0).cgColor,
            UIColor(red: 0.07, green: 0.10, blue: 0.18, alpha: 1.0).cgColor
        ]
        backgroundGradientLayer.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradientLayer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.insertSublayer(backgroundGradientLayer, at: 0)
    }
    
    private func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(tapButton)
        tapButton.addSubview(counterLabel)
        view.addSubview(resetButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tapButton.widthAnchor.constraint(equalToConstant: 200),
            tapButton.heightAnchor.constraint(equalToConstant: 200),
            
            counterLabel.centerXAnchor.constraint(equalTo: tapButton.centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: tapButton.centerYAnchor),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: 50),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    @objc private func didTap() {
        counter += 1
        counterLabel.text = "\(counter)"
        
        UserDefaults.standard.set(counter, forKey: counterKey)
        
        impactFeedback.impactOccurred()
        
        UIView.animate(withDuration: 0.1, animations: {
            self.tapButton.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.tapButton.transform = .identity
            }
        }
    }
    
    @objc private func didReset() {
        successFeedback.notificationOccurred(.warning)
        
        let alert = UIAlertController(title: "تصفير العداد", message: "هل أنت متأكد أنك تريد تصفير عداد المسبحة؟", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel, handler: nil)
        
        let resetAction = UIAlertAction(title: "تصفير", style: .destructive) { _ in
            self.counter = 0
            self.counterLabel.text = "0"
            
            UserDefaults.standard.set(self.counter, forKey: self.counterKey)
            
            self.successFeedback.notificationOccurred(.success)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(resetAction)
        
        present(alert, animated: true)
    }
}
