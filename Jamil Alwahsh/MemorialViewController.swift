


import UIKit

class MemorialViewController: UIViewController {

    // MARK: - Data
    var currentDuaa = ""
    
    var duaasList = [
        "اللهم اغفر له وارحمه وعافه واعف عنه، وأكرم نزله ووسع مدخله.",
        "اللهم أبدله داراً خيراً من داره، وأهلاً خيراً من أهله، وأدخله الجنة.",
        "اللهم اجعل قبره روضة من رياض الجنة، ولا تجعله حفرة من حفر النار.",
        "اللهم انقله من مواطن الدود وضيق اللحود إلى جنات الخلود.",
        "اللهم آنسه في وحدته، وفي وحشته، وفي غربته.",
        "اللهم يمن كتابه، ويسر حسابه، وثقل بالحسنات ميزانه.",
        "اللهم اجعله في بطن القبر مطمئناً، وعند قيام الأشهاد آمناً."
    ]
    
    private let duaasKey = "savedDuaasList"
    
    // MARK: - UI Components
    private let backgroundGradientLayer = CAGradientLayer()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "father_photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "والدي الحبيب"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let daysContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        return view
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.cyan.withAlphaComponent(0.8)
        label.textAlignment = .center
        return label
    }()
    
    private let duaaEffectView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let view = UIVisualEffectView(effect: blur)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        return view
    }()
    
    private let duaaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var shareButton = createBottomButton(title: "مشاركة", iconName: "square.and.arrow.up.fill", action: #selector(didTapShare))
    
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var rosaryButton = createBottomButton(title: "المسبحة", iconName: "hand.tap.fill", action: #selector(didTapRosary))
    
    private lazy var addButton = createBottomButton(title: "إضافة", iconName: "plus", action: #selector(didTapAddDuaa))
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupViews()
        setupConstraints()
        refreshDuaa()
        configureData()
        
        if let savedDuaas = UserDefaults.standard.stringArray(forKey: duaasKey) {
            duaasList = savedDuaas
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshDuaa), name: UIApplication.willEnterForegroundNotification, object: nil)
        
        NotificationManager.shared.requestPermission(duaas: duaasList)
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
        view.addSubview(profileImageView)
        view.addSubview(titleLabel)
        
        view.addSubview(daysContainerView)
        daysContainerView.addSubview(daysLabel)
        
        view.addSubview(duaaEffectView)
        duaaEffectView.contentView.addSubview(duaaLabel)
        
        buttonsStackView.addArrangedSubview(addButton)
        buttonsStackView.addArrangedSubview(shareButton)
        buttonsStackView.addArrangedSubview(rosaryButton)
        view.addSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            titleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            daysContainerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            daysContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            daysContainerView.heightAnchor.constraint(equalToConstant: 35),
            
            daysLabel.leadingAnchor.constraint(equalTo: daysContainerView.leadingAnchor, constant: 16),
            daysLabel.trailingAnchor.constraint(equalTo: daysContainerView.trailingAnchor, constant: -16),
            daysLabel.centerYAnchor.constraint(equalTo: daysContainerView.centerYAnchor),
            
            duaaEffectView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40),
            duaaEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            duaaEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            duaaLabel.topAnchor.constraint(equalTo: duaaEffectView.topAnchor, constant: 30),
            duaaLabel.bottomAnchor.constraint(equalTo: duaaEffectView.bottomAnchor, constant: -30),
            duaaLabel.leadingAnchor.constraint(equalTo: duaaEffectView.leadingAnchor, constant: 20),
            duaaLabel.trailingAnchor.constraint(equalTo: duaaEffectView.trailingAnchor, constant: -20),
            
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    // MARK: - Logic & Actions
    private func configureData() {
        duaaLabel.text = currentDuaa
        
        let daysPassed = calculateDaysSincePassing()
        daysLabel.text = "\(daysPassed) يوماً في رحاب الله"
        
        if let sharedDefaults = UserDefaults(suiteName: "group.com.wahsh.MemorialApp") {
            sharedDefaults.set(daysPassed, forKey: "sharedDaysPassed")
            sharedDefaults.set(currentDuaa, forKey: "sharedCurrentDuaa")
            sharedDefaults.synchronize()
        }
    }

    private func calculateDaysSincePassing() -> Int {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = 2026
        dateComponents.month = 7
        dateComponents.day = 15
        
        guard let passingDate = calendar.date(from: dateComponents) else { return 0 }
        
        let startOfPassingDate = calendar.startOfDay(for: passingDate)
        let startOfToday = calendar.startOfDay(for: Date())
        
        let components = calendar.dateComponents([.day], from: startOfPassingDate, to: startOfToday)
        return components.day ?? 0
    }
    
    @objc private func didTapShare() {
        let activityVC = UIActivityViewController(activityItems: [currentDuaa], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    @objc private func refreshDuaa() {
        if let randomDuaa = duaasList.randomElement() {
            currentDuaa = randomDuaa
            duaaLabel.text = currentDuaa
            
            if let sharedDefaults = UserDefaults(suiteName: "group.com.wahsh.MemorialApp") {
                sharedDefaults.set(currentDuaa, forKey: "sharedCurrentDuaa")
            }
        }
    }
    
    @objc private func didTapRosary() {
        let rosaryVC = RosaryViewController()
        rosaryVC.modalPresentationStyle = .pageSheet
        if let sheet = rosaryVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        present(rosaryVC, animated: true)
    }
    
    @objc private func didTapAddDuaa() {
        let alert = UIAlertController(title: "إضافة دعاء", message: "اكتب دعاء جديد لجميل الوحش رحمه الله", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "اللهم..."
            textField.textAlignment = .right
        }
        
        let saveAction = UIAlertAction(title: "حفظ", style: .default) { [weak self] _ in
            guard let self = self, let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            
            self.duaasList.append(text)
            UserDefaults.standard.set(self.duaasList, forKey: self.duaasKey)
            
            self.currentDuaa = text
            self.duaaLabel.text = self.currentDuaa
            
            if let sharedDefaults = UserDefaults(suiteName: "group.com.wahsh.MemorialApp") {
                sharedDefaults.set(self.currentDuaa, forKey: "sharedCurrentDuaa")
                sharedDefaults.synchronize()
            }
            
            NotificationManager.shared.scheduleDuaasEveryTenMinutes(duaas: self.duaasList)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
        let cancelAction = UIAlertAction(title: "إلغاء", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Helper Methods
    private func createBottomButton(title: String, iconName: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
        let image = UIImage(systemName: iconName, withConfiguration: config)
        button.setImage(image, for: .normal)
        button.setTitle(" \(title)", for: .normal)
        
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        button.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.withAlphaComponent(0.1).cgColor
        
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}
