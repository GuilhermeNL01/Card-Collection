//
//  TapGestureRecognizer.swift
//  My Card Collection
//
//  Created by Guilherme Nunes Lobo on 18/08/24.
//

import SwiftUI

struct TapGestureRecognizer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let tapGesture = UITapGestureRecognizer(target: viewController.view, action: #selector(viewController.view.endEditing))
        viewController.view.addGestureRecognizer(tapGesture)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
