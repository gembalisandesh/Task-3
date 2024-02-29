import SwiftUI
import UIKit

extension View {
    func asUIImage(size: CGSize) -> UIImage? {
        
        let hostingController = UIHostingController(rootView: self)
        hostingController.view.bounds = CGRect(origin: .zero, size: size)
        hostingController.view.backgroundColor = UIColor.clear

        
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { _ in
            hostingController.view.drawHierarchy(in: hostingController.view.bounds, afterScreenUpdates: true)
        }

        return image
    }
}
