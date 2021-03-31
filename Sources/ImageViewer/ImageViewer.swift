import SwiftUI
import UIKit

@available(iOS 13.0, *)
public struct ImageViewer: View {
    @Binding var viewerShown: Bool
    @Binding var image: Image
    @Binding var imageOpt: Image?
    @State var caption: Text?
    @State var closeButtonTopRight: Bool?
    
    var aspectRatio: Binding<CGFloat>?
    
    @State var dragOffset: CGSize = CGSize.zero
    @State var dragOffsetPredicted: CGSize = CGSize.zero
    
    public init(image: Binding<Image>, viewerShown: Binding<Bool>, aspectRatio: Binding<CGFloat>? = nil, caption: Text? = nil, closeButtonTopRight: Bool? = false) {
        _image = image
        _viewerShown = viewerShown
        _imageOpt = .constant(nil)
        self.aspectRatio = aspectRatio
        _caption = State(initialValue: caption)
        _closeButtonTopRight = State(initialValue: closeButtonTopRight)
    }
    
    public init(image: Binding<Image?>, viewerShown: Binding<Bool>, aspectRatio: Binding<CGFloat>? = nil, caption: Text? = nil, closeButtonTopRight: Bool? = false) {
        _image = .constant(Image(systemName: ""))
        _imageOpt = image
        _viewerShown = viewerShown
        self.aspectRatio = aspectRatio
        _caption = State(initialValue: caption)
        _closeButtonTopRight = State(initialValue: closeButtonTopRight)
    }
    
    func getImage() -> Image {
        if(self.imageOpt == nil) {
            return self.image
        }
        else {
            return self.imageOpt ?? Image(systemName: "questionmark.diamond")
        }
    }

    @ViewBuilder
    public var body: some View {
        VStack {
            if(viewerShown) {
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
                            self.getImage()
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
