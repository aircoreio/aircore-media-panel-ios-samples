//
//  Panel.swift
//  sample
//
//  Created by Deepak on 10/5/22.
//

import Foundation
import SwiftUI
struct Panel: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> PanelViewController {
        let viewController = PanelViewController()
        //additional setup
        return viewController
    }
    func updateUIViewController(_ uiViewController: PanelViewController, context: Context) {
        //update Content
    }
}
