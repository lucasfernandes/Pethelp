//
//  KeyboardState.swift
//  PetHelp
//
//  Created by Lucas Silveira on 09/09/20.
//

import Foundation
import NotificationCenter

class KeyboardState: ObservableObject {
    @Published var isOpen = false
    @Published var keyboardHeight: CGFloat = 0

    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyBoardDidHide(notification:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidShowNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            guard let userInfo = notification.userInfo,
                  let keyboardRect = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

            self.keyboardHeight = keyboardRect.height
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardDidHideNotification,
                                               object: nil,
                                               queue: .main) { (notification) in
            self.keyboardHeight = 0
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyBoardWillShow(notification: Notification) {
        self.isOpen = true
    }

    @objc func keyBoardDidHide(notification: Notification) {
        self.isOpen = false
    }
}
