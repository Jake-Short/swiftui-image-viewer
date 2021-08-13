//
//  ImageViewerSupport.swift
//  ImageViewerSupport
//
//  Created by Maciej Świć on 2021-08-13.
//

import SwiftUI
import ImageViewer

extension View {
    /// Attaches an image viewer to this view using a PreferenceKey.
    ///
    /// Allows this view to display images as requested by child views further down in the view hierarchy, without having to manually pass the image throught the view hierarchy.
    ///
    /// For example, you can attach this modifier to a `NavigationView` and use the `viewImage(image: UIImage?)`modifier on any view further down in the hierarchy.
    public func imageViewier() -> some View {
        self.modifier(ImageViewerViewModifier())
    }
    
    /// Sets the image to be viewed with the `imageViewer()` modifer.
    ///
    /// Use this on the child view to specify which image should be viewed higher up in the hierarchy.
    ///
    /// For example, you can use this modifier on a `Button` in a `List` several hierarchies down where you don't have access to a `NavigationView`.
    ///
    /// Then, you can use the `imageViewer()` modifier anywhere higher up in that hierarchy, for example on a `NavigationView` to display the image properly.
    public func viewImage(image: UIImage?) -> some View {
        self.modifier(ImageViewerSetModifier(image: image))
    }
}

struct ImageViewerViewModifier: ViewModifier {
    @State var isShowingImage = false
    @State var imagePreference: Image? {
        didSet {
            isShowingImage = imagePreference != nil
        }
    }
    
    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ImageViewPreferenceKey.self) { image in
                guard let image = image else { return }
                
                imagePreference = Image(uiImage: image)
            }
            .overlay {
                ImageViewer(image: $imagePreference, viewerShown: $isShowingImage)
            }
    }
}

struct ImageViewerSetModifier: ViewModifier {
    var image: UIImage?
    
    func body(content: Content) -> some View {
        content
            .preference(key: ImageViewPreferenceKey.self, value: image)
    }
}

struct ImageViewPreferenceKey: PreferenceKey {
    static var defaultValue: UIImage?
    
    static func reduce(value: inout UIImage?, nextValue: () -> UIImage?) {
        guard let nextValue = nextValue() else { return }
        
        value = nextValue
    }
}
