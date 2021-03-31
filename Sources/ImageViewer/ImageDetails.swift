import SwiftUI

public struct ImageDetails {
    var image: Image?
    var aspectRatio: CGFloat?
    var caption: String?
    
    public init(image: Image?, aspectRatio: CGFloat? = nil, caption: String? = nil) {
        self.image = image
        self.aspectRatio = aspectRatio
        self.caption = caption
    }
}

public struct ImageDetailsRemote {
    public var imageURL: String
    var aspectRatio: CGFloat?
    var caption: String?
    
    public init(imageURL: String, aspectRatio: CGFloat? = nil, caption: String? = nil) {
        self.imageURL = imageURL
        self.aspectRatio = aspectRatio
        self.caption = caption
    }
}
