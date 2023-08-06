import UIKit

public final class TabBarController: UITabBarController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        setup()
    }
    
    func setup() {
        tabBar.backgroundColor = .mainColor
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .black
    }
    
    func setupVCs() {
            viewControllers = [
                createNavController(for: DraftViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house.fill")!),
                createNavController(for: DraftViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "chart.bar.fill")!),
                createNavController(for: DraftViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "plus.circle")!),
                makeSettingsScene()
            ]
        }
    
    func createNavController(
        for rootViewController: UIViewController,
        title: String,
        image: UIImage
    ) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            rootViewController.navigationItem.title = title
            return navController
    }
}

// MARK: - Settings

private extension TabBarController {
    func makeSettingsScene() -> UIViewController {
        createNavController(
            for: SettingsScene.start(openTechSupportScene: openTechSupportScene),
            title: NSLocalizedString("Settings", comment: ""),
            image: UIImage(systemName: "gearshape.fill")!
        )
    }
    
    func openTechSupportScene(_ rootViewController: UIViewController) {
        TechSupportScene.start(rootViewController: rootViewController)
    }
}

// MARK: - Add


