# SwiftUI Image Viewer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://GitHub.com/Naereen/StrapDown.js/graphs/commit-activity)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


# Summary

An image viewer built using SwiftUI. Featuring drag to dismiss, pinch to zoom, remote and local images, and more.

![image](https://media2.giphy.com/media/LSKUWsW9KogOLIS2ZS/giphy.gif?cid=4d1e4f29cacda6de9a149bb9b7a2717faec03a9ebd6d5fdd&rid=giphy.gif)

# Installation via Swift Package Manager

File > Swift Packages > Add Package Dependancy

```https://github.com/Jake-Short/swiftui-image-viewer.git```

# Usage

### Local Image:

The `image` parameter accepts `Binding<Image>` in all versions. As of 1.0.20, it also accepts `Binding<Image?>`

```Swift
import ImageViewer

struct ContentView: View {
    @State var showImageViewer: Bool = true
    @State var image = Image("example-image")
	
    var body: some View {
        VStack {
            Text("Example!")
        }
	.frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer))
    }
}
```

### Remote Image:

The `imageURL` parameter accepts `Binding<String>`

```Swift
import ImageViewerRemote

struct ContentView: View {
    @State var showImageViewer: Bool = true
    @State var imgURL: String = "https://..."
	
    var body: some View {
        VStack {
            Text("Example!")
        }
	.frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(ImageViewerRemote(imageURL: self.$imgURL, viewerShown: self.$showImageViewer))
    }
}
```

# Customization

### HTTP Headers

#### Availability: 1.0.15 or higher

The remote image viewer allows HTTP headers to be included in the URL request. To use them, pass a dictonary to the httpHeaders field. The format should be [Header: Value], both strings.

Example:
```Swift
import ImageViewerRemote

struct ContentView: View {
    @State var showImageViewer: Bool = true
	
    var body: some View {
        VStack {
            Text("Example!")
        }
	.frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(ImageViewerRemote(imageURL: URL(string: "https://..."), viewerShown: self.$showImageViewer, httpHeaders: ["X-Powered-By": "Swift!"]))
    }
}
```

### Explicit Aspect Ratio

#### Availability: 1.0.21 or higher

An explcit image aspect ratio can be specified, which fixes an issue of incorrect stretching that occurs in certain situations. The `aspectRatio` parameter accepts `Binding<CGFloat>`

Example:
```Swift
import ImageViewer

struct ContentView: View {
    @State var showImageViewer: Bool = true
    @State var image = Image("example-image")
	
    var body: some View {
        VStack {
            Text("Example!")
        }
	.frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer, aspectRatio: .constant(2)))
    }
}
```

# Compatibility

This package is compatible on iOS 13 and later.

Previous to 1.0.18, this package used Swift tools version 5.2. If you receive an error while trying to use the package, you may be on an older version of Xcode, and should use version 1.0.18 of this package or later.

As of 1.0.18 and later, this package uses Swift tools version 5.1, allowing for compatibility with more Xcode versions.

## License

This project is licensed under the MIT license.

## Enjoying this project?

Please consider giving it a star!
