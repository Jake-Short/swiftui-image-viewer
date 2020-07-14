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
```Swift
import ImageViewer

struct ContentView: View {
    @State var showImageViewer: Bool = true
	
    var body: some View {
        VStack {
            Text("Example!")
        }
        .overlay(ImageViewer(image: Image("example-image"), viewerShown: self.$showImageViewer))
    }
}
```

### Remote Image:
```Swift
import ImageViewerRemote

struct ContentView: View {
    @State var showImageViewer: Bool = true
	
    var body: some View {
        VStack {
            Text("Example!")
        }
        .overlay(ImageViewerRemote(imageURL: URL(string: "https://..."), viewerShown: self.$showImageViewer))
    }
}
```

# Customization

The remote image can optionally take HTTP headers to include in the URL request. To use them, pass a dictonary to the httpHeaders field. The format should be [Header: Value], both strings.
#### Availability: 1.0.15 or higher
Example:
```Swift
import ImageViewerRemote

struct ContentView: View {
    @State var showImageViewer: Bool = true
	
    var body: some View {
        VStack {
            Text("Example!")
        }
        .overlay(ImageViewerRemote(imageURL: URL(string: "https://..."), viewerShown: self.$showImageViewer, httpHeaders: ["X-Powered-By": "Swift!"]))
    }
}
```

# Compatibility

This package is compatible on iOS 13 and later.

Previous to 1.0.18, this package used Swift tools version 5.2. If you receive an error while trying to use the package, you may be on an older version of Xcode, and should use version 1.0.18 of this package or later.

As of 1.0.18 and later, this package uses Swift tools version 5.1, allowing for compatibility with more Xcode versions.

## License

This project is licensed under the MIT license.
