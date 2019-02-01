import UIKit

class ProductCardViewController: UIViewController {

    init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    var distanceFromCenter: CGFloat = 0 {
        didSet { view.setNeedsLayout() }
    }

    // MARK: View

    override func loadView() {
        view = ProductCardView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        productCardView.topBackgroundView.backgroundColor = product.color
        productCardView.imageView.image = product.image
        productCardView.updateImageViewLayout()
        productCardView.nameLabel.text = product.name
        productCardView.priceLabel.text = product.price
        productCardView.button.titleLabel.text = "Show more"
    }

    private var productCardView: ProductCardView! {
        return view as? ProductCardView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let progress = min(1, max(-1, distanceFromCenter / view.bounds.width))
        productCardView.topBackgroundView.alpha = 1 - abs(progress * 0.25)
        var imageViewTransform = CGAffineTransform.identity
        imageViewTransform = imageViewTransform.translatedBy(x: 32 * progress, y: 0)
        imageViewTransform = imageViewTransform.rotated(by: -9 / 360 * CGFloat.pi * progress)
        productCardView.imageView.transform = imageViewTransform
    }

    // MARK: Private

    private let product: Product

}