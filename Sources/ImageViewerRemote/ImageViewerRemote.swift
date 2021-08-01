import SwiftUI
import UIKit
import URLImage
import Combine
import ImageViewer

@available(iOS 13.0, *)
public struct ImageViewerRemote: View {
    @Binding var viewerShown: Bool
    var imageURL: String
    var disableCache: Bool?
    var caption: Text?
    var closeButtonAlignment: CloseButtonAlignment? = CloseButtonAlignment.topLeft
    
    var aspectRatio: Binding<CGFloat>?
    
    @State var dragOffset: CGSize = CGSize.zero
    @State var dragOffsetPredicted: CGSize = CGSize.zero
    
    @ObservedObject var loader: ImageLoader
    
    public init(imageURL: String, viewerShown: Binding<Bool>, aspectRatio: Binding<CGFloat>? = nil, disableCache: Bool? = nil, caption: Text? = nil, closeButtonAlignment: CloseButtonAlignment?) {
        self.imageURL = imageURL
        _viewerShown = viewerShown
        self.disableCache = disableCache
        self.aspectRatio = aspectRatio
        self.caption = caption
        self.closeButtonAlignment = closeButtonAlignment
        
        loader = ImageLoader(url: .constant(imageURL))
    }

    @ViewBuilder
    public var body: some View {
        VStack {
            if(viewerShown && imageURL.count > 0) {
                ZStack {
                    if self.closeButtonAlignment != CloseButtonAlignment.hidden {
                        VStack {
                            if self.closeButtonAlignment == CloseButtonAlignment.bottomLeft ||
                                self.closeButtonAlignment == CloseButtonAlignment.bottomRight {
                                Spacer()
                            }
                            HStack {
                                
                                if self.closeButtonAlignment == CloseButtonAlignment.topRight ||
                                    self.closeButtonAlignment == CloseButtonAlignment.bottomRight {
                                    Spacer()
                                }
                                
                                Button(action: { self.viewerShown = false }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color(UIColor.white))
                                        .font(.system(size: UIFontMetrics.default.scaledValue(for: 24)))
                                }
                                
                                
                                if self.closeButtonAlignment == CloseButtonAlignment.topLeft ||
                                    self.closeButtonAlignment == CloseButtonAlignment.bottomLeft {
                                    Spacer()
                                }
                            }
                            
                            if self.closeButtonAlignment == CloseButtonAlignment.topLeft ||
                                self.closeButtonAlignment == CloseButtonAlignment.topRight {
                                Spacer()
                            }
                        }
                        .padding()
                        .zIndex(2)
                    }
                    
                    VStack {
                        ZStack {
                            if(self.disableCache == nil || self.disableCache == false) {
                                URLImage(url: URL(string: self.imageURL) ?? URL(string: "https://via.placeholder.com/150.png")!, content: { image in
                                image
                                    .resizable()
                                    .aspectRatio(self.aspectRatio?.wrappedValue, contentMode: .fit)
                                    .offset(x: self.dragOffset.width, y: self.dragOffset.height)
                                    .rotationEffect(.init(degrees: Double(self.dragOffset.width / 30)))
                                    .pinchToZoom()
                                    .gesture(DragGesture()
                                        .onChanged { value in
                                            self.dragOffset = value.translation
                                            self.dragOffsetPredicted = value.predictedEndTranslation
                                        }
                                        .onEnded { value in
                                            if((abs(self.dragOffset.height) + abs(self.dragOffset.width) > 570) || ((abs(self.dragOffsetPredicted.height)) / (abs(self.dragOffset.height)) > 3) || ((abs(self.dragOffsetPredicted.width)) / (abs(self.dragOffset.width))) > 3) {
                                                withAnimation(.spring()) {
                                                    self.dragOffset = self.dragOffsetPredicted
                                                }
                                                self.viewerShown = false
                                                return
                                            }
                                            withAnimation(.interactiveSpring()) {
                                                self.dragOffset = .zero
                                            }
                                        }
                                    )
                                })
                            }
                            else {
                                if loader.image != nil {
                                    Image(uiImage: loader.image!)
                                        .resizable()
                                        .aspectRatio(self.aspectRatio?.wrappedValue, contentMode: .fit)
                                        .offset(x: self.dragOffset.width, y: self.dragOffset.height)
                                        .rotationEffect(.init(degrees: Double(self.dragOffset.width / 30)))
                                        .pinchToZoom()
                                        .gesture(DragGesture()
                                            .onChanged { value in
                                                self.dragOffset = value.translation
                                                self.dragOffsetPredicted = value.predictedEndTranslation
                                            }
                                            .onEnded { value in
                                                if((abs(self.dragOffset.height) + abs(self.dragOffset.width) > 570) || ((abs(self.dragOffsetPredicted.height)) / (abs(self.dragOffset.height)) > 3) || ((abs(self.dragOffsetPredicted.width)) / (abs(self.dragOffset.width))) > 3) {
                                                    withAnimation(.spring()) {
                                                        self.dragOffset = self.dragOffsetPredicted
                                                    }
                                                    self.viewerShown = false
                                                    return
                                                }
                                                withAnimation(.interactiveSpring()) {
                                                    self.dragOffset = .zero
                                                }
                                            }
                                        )
                                }
                                else {
                                    Text(":/")
                                }
                            }
                            
                            if(self.caption != nil) {
                                VStack {
                                    Spacer()
                                    
                                    VStack {
                                        Spacer()
                                        
                                        HStack {
                                            Spacer()
                                            
                                            self.caption
                                                .foregroundColor(.white)
                                                .multilineTextAlignment(.center)
                                            
                                            Spacer()
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.12, green: 0.12, blue: 0.12, opacity: (1.0 - Double(abs(self.dragOffset.width) + abs(self.dragOffset.height)) / 1000)).edgesIgnoringSafeArea(.all))
                    .zIndex(1)
                }
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                .onAppear() {
                    self.dragOffset = .zero
                    self.dragOffsetPredicted = .zero
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: Binding<String>
    private var cancellable: AnyCancellable?
    
    func getURLRequest(url: String) -> URLRequest {
        let url = URL(string: url) ?? URL(string: "https://via.placeholder.com/150.png")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request;
    }

    init(url: Binding<String>) {
        self.url = url
        
        if(url.wrappedValue.count > 0) {
            load()
        }
    }
    
    deinit {
        cancellable?.cancel()
    }

    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: getURLRequest(url: self.url.wrappedValue))
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
