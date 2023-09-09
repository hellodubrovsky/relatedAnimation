import UIKit

class ViewController: UIViewController {

    private let animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)

    private lazy var squareView: UIView = {
        let view = UIView(frame: CGRect(x: view.layoutMargins.left, y: 100, width: 100, height: 100))
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 5
        return view
    }()

    private lazy var slider: UISlider = {
        let slider = UISlider(frame: CGRect(x: view.layoutMargins.left,
                                            y: 250,
                                            width: UIScreen.main.bounds.width - view.layoutMargins.left - view.layoutMargins.right,
                                            height: 30))
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.addTarget(self, action: #selector(moveFigure), for: .valueChanged)
        return slider
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: view.layoutMargins.top,
                                          left: 20,
                                          bottom: view.layoutMargins.bottom,
                                          right: 20)
        view.addSubview(squareView)
        view.addSubview(slider)
        animator.addAnimations {
            self.squareView.frame = CGRect(x: UIScreen.main.bounds.width - (self.squareView.frame.width * 1.25) - self.view.layoutMargins.right,
                                           y: 100,
                                           width: self.squareView.frame.width * 1.25,
                                           height: self.squareView.frame.height * 1.25)
            self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            self.slider.addTarget(self, action:#selector(self.startAnimation), for: [.touchUpOutside, .touchUpInside])
            self.animator.pausesOnCompletion = true
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.layoutMarginsDidChange()
    }


    // MARK: - Private Methods

    @objc
    private func moveFigure() {
        animator.fractionComplete = CGFloat(self.slider.value)
    }

    @objc
    private func startAnimation() {
        animator.startAnimation()
        slider.setValue(slider.maximumValue, animated: true)
    }
}
