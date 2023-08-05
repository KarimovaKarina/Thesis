import UIKit

internal class LoadingView: UIView {
    override public var isHidden: Bool {
        didSet {
            if isHidden {
                indicator.stopAnimating()
            } else {
                indicator.startAnimating()
            }
        }
    }

    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()

    private var indicatorColor: UIColor
    private var viewBackgroundColor: UIColor

    public init(
        activityIndicatorColor: UIColor,
        viewBackgroundColor: UIColor
    ) {
        indicatorColor = activityIndicatorColor
        self.viewBackgroundColor = viewBackgroundColor
        super.init(frame: .zero)
        prepareView()
        prepareLayout()
    }

    public convenience init() {
        self.init(
            activityIndicatorColor: .black,
            viewBackgroundColor: .white
        )
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareView() {
        backgroundColor = viewBackgroundColor
        indicator.color = indicatorColor
        addSubview(indicator)
        isHidden = true
    }

    private func prepareLayout() {
        indicator.constrain(.horizontal, to: self)
        indicator.constrain(.vertical, to: self)
    }
}
