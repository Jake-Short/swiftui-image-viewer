import SwiftUI
import ImageViewer
import URLImage

@available(iOS 13.0, *)
public struct ImageViewerRemote: View {
    
    var imageDetails: ImageDetailsRemote
    var disableCache: Bool
    var closeButtonTopRight: Bool?
    
    @Binding var viewerShown: Bool
    
    @ObservedObject var loader: ImageLoader
    
    public init(imageDetails: ImageDetailsRemote, viewerShown: Binding<Bool>, disableCache: Bool = false, closeButtonTopRight: Bool? = nil) {
        self.imageDetails = imageDetails
        _viewerShown = viewerShown
        self.disableCache = disableCache
        self.closeButtonTopRight = closeButtonTopRight
        loader = ImageLoader(url: imageDetails.imageURL)
    }
    
    public init(imageURL: String, viewerShown: Binding<Bool>, aspectRatio: CGFloat? = nil, caption: String? = nil, disableCache: Bool = false, closeButtonTopRight: Bool? = nil) {
        imageDetails = ImageDetailsRemote(imageURL: imageURL, aspectRatio: aspectRatio, caption: caption)
        _viewerShown = viewerShown
        self.disableCache = disableCache
        self.closeButtonTopRight = closeButtonTopRight
        loader = ImageLoader(url: imageURL)
    }
    
    @ViewBuilder
    public var body: some View {
        VStack {
            if(viewerShown && !imageDetails.imageURL.isEmpty) {
                ZStack {
                    VStack {
                        HStack {
                              
                            if self.closeButtonTopRight == true {
                                Spacer()
                            }
                            
                            Button(action: { self.viewerShown = false }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(UIColor.white))
                                    .font(.system(size: UIFontMetrics.default.scaledValue(for: 24)))
                            }
                            
                            
                            if self.closeButtonTopRight != true {
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .zIndex(2)
                    
                    VStack {
                        ZStack {
                            if !disableCache {
                                URLImage(url: URL(string: imageDetails.imageURL) ?? URL(string: "https://via.placeholder.com/150.png")!, content: { image in
                                    ImageView(imageDetails: ImageDetails(image: image), viewerShown: $viewerShown)
                                })
                            }
                            else {
                                if let image = loader.image {
                                    ImageView(imageDetails: ImageDetails(image: Image(uiImage: image)), viewerShown: $viewerShown)
                                }
                                else {
                                    Text(":/")
                                }
                            }
                        }
                    }
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
