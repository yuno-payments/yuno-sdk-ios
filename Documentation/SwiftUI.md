## SwiftUI Implementation

To show the payment methods into your SwiftUI view, you should use the wrapper UIViewControllerRepresentable which represent the ViewController responsable of showing the SDK views, as in the following example

```swift
struct PaymentMethodsView: View  {
    var body: some View {
        ScrollView {
            YunoView()
        }
    }
}

struct YunoView: UIViewControllerRepresentable {
    typealias UIViewControllerType = YunoViewController
    
    func makeUIViewController(context: Context) -> YunoViewController {
        let viewController = YunoViewController()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: YunoViewController, context: Context) { }
}

class YunoViewController: YunoPaymentDelegate, YunoMethodsViewDelegate {

    func viewDidLoad() {
        super.viewDidLoad()
        Yuno.startCheckout(with: self)
        Yuno.methodsView(delegate: self)
        generator.getPaymentMethodsView(checkoutSession: checkoutSession) { [weak self] (view: UIView) in
        // Add view to your superview
        }
    }
}
```
The `preferredContentSize` property has to be added to your viewController for the payment methods to show correctly in your SwiftUI view

```swift
preferredContentSize = view.frame.size
 ```