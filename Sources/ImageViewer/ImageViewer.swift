import SwiftUI

@available(iOS 13.0, *)
public struct ImageViewer: View {
    
    var imageDetails: ImageDetails
    var closeButtonTopRight: Bool
    
    @Binding var viewerShown: Bool
    
    public init(imageDetails: ImageDetails, viewerShown: Binding<Bool>, closeButtonTopRight: Bool = false) {
        self.imageDetails = imageDetails
        _viewerShown = viewerShown
        self.closeButtonTopRight = closeButtonTopRight
    }
    
    public init(image: Image?, viewerShown: Binding<Bool>, aspectRatio: CGFloat? = nil, caption: String? = nil, closeButtonTopRight: Bool = false) {
        self.init(imageDetails: ImageDetails(image: image, aspectRatio: aspectRatio, caption: caption), viewerShown: viewerShown, closeButtonTopRight: closeButtonTopRight)
    }
    
    @ViewBuilder
    public var body: some View {
        VStack {
            if(viewerShown) {
                ZStack {
                    VStack {
                        HStack {
                            
                            if closeButtonTopRight {
                                Spacer()
                            }
                            
                            Button(action: { self.viewerShown = false }) {
                                Image(systemName: "xmark")
                                    .foregroundColor(Color(UIColor.white))
                                    .font(.system(size: UIFontMetrics.default.scaledValue(for: 24)))
                            }
                            
                            if !closeButtonTopRight {
                                Spacer()
                            }
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .zIndex(2)
                    
                    ImageView(imageDetails: imageDetails, viewerShown: $viewerShown)
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
