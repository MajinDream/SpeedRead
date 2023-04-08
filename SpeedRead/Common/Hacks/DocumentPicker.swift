//
//  DocumentPicker.swift
//  SpeedRead
//
//  Created by Dias Manap on 09.04.2023.
//

import SwiftUI
import UIKit

class DocumentPickerCoordinator: NSObject, UIDocumentPickerDelegate {
    @Binding var isShown: Bool
    @Binding var url: URL?
    
    init(isShown: Binding<Bool>, url: Binding<URL?>) {
        _isShown = isShown
        _url = url
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        self.url = url
        isShown = false
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        isShown = false
    }
}

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var isShown: Bool
    @Binding var url: URL?
    
    func makeCoordinator() -> DocumentPickerCoordinator {
        return DocumentPickerCoordinator(isShown: $isShown, url: $url)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<DocumentPicker>) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.text, .plainText, .epub, .pdf])
        documentPicker.delegate = context.coordinator
        return documentPicker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<DocumentPicker>) {
        // No need to update anything here
    }
}
