# SwiftUI Image Viewer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/Jake-Short/swiftui-image-viewer/graphs/commit-activity)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)


# Summary

An image viewer built using SwiftUI. Featuring drag to dismiss, pinch to zoom, remote and local images, and more.

![image](https://media2.giphy.com/media/LSKUWsW9KogOLIS2ZS/giphy.gif?cid=4d1e4f29cacda6de9a149bb9b7a2717faec03a9ebd6d5fdd&rid=giphy.gif)

# Installation via Swift Package Manager

File > Swift Packages > Add Package Dependancy

```https://github.com/Jake-Short/swiftui-image-viewer.git```

# Usage

> **Notes on NavigationView:** The `.overlay` modifier only applies to the view it is applied to. Therefore, the `.overlay` modifier *must* be applied to the NavigationView to appear above all elements! If it is applied to a child view, it will appear beneath the title/navigation buttons.

### Local Image:

The `image` parameter accepts `Image` or `Image?` in versions >= 3.0.0.
<details>
<summary>Previous Versions</summary>
<br>

All versions <3.0.0 accept `Binding<Image>`. >=1.0.20 and <3.0.0 also accept `Binding<Image?>`.
</details>

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
        .overlay(ImageViewer(image: self.image, viewerShown: self.$showImageViewer))
    }
}
```

### Remote Image:

The `imageURL` parameter accepts `String`
<details>
<summary>Previous Versions</summary>
<br>

All versions <3.0.0 accept `Binding<String>`.
</details>

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
        .overlay(ImageViewerRemote(imageURL: self.imgURL, viewerShown: self.$showImageViewer))
    }
}
```

# Customization

### Close Button Position

#### Availability: 3.0.0 or higher
*Optional:* Defaults to .topLeft

The close button position can be customized. The `closeButtonAlignment` parameter is an enum that accepts `.topLeft`, `.topRight`, `.bottomLeft`, `.bottomRight`, and `.hidden`.

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
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer, closeButtonAlignment: .topLeft))
    }
}
```


### Caption

#### Availability: 2.1.0 or higher
*Optional*

A caption can be added to the image viewer. The caption will appear near the bottom of the image viewer (if the image fills the whole screen the text will appear on top of the image). The `caption` parameter accepts `Text`.

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
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer, caption: Text("This is a caption!")))
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

### Disable Cache

#### Availability: 1.0.25 or higher

To disable cache on the remote image viewer, simply pass a `Bool` value to the `disableCache` parameter

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
        .overlay(ImageViewerRemote(imageURL: URL(string: "https://..."), viewerShown: self.$showImageViewer, disableCache: true))
    }
}
```
<details>
<summary>Deprecated</summary>
<br>
	
### HTTP Headers

#### Availability: 1.0.15 to 1.0.25
#### *DEPRECATED*: No longer available as of 2.0.0

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

### Close Button Position

#### Availability: Below 3.0.0
#### *DEPRECATED*: View new usage above for >= 3.0.0

The close button can be moved to the top right if desired. The `closeButtonTopRight` parameter accepts `bool`.

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
        .overlay(ImageViewer(image: self.$image, viewerShown: self.$showImageViewer, closeButtonTopRight: true))
    }
}
```
</details>

# Compatibility

This package is compatible on iOS 13 and later.

Previous to 1.0.18, this package used Swift tools version 5.2. If you receive an error while trying to use the package, you may be on an older version of Xcode, and should use version 1.0.18 of this package or later.

As of 1.0.18 and later, this package uses Swift tools version 5.1, allowing for compatibility with more Xcode versions.

## License

This project is licensed under the MIT license.

## Enjoying this project?

Please consider giving it a star!
