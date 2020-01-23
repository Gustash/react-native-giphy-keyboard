# react-native-giphy-keyboard

### This module implements the iOS and Android SDKs from Giphy for a simple usage. No more fumbling around with the Giphy API!

## Getting started

Install the package with:

`npm install react-native-giphy-keyboard`

or

`yarn add react-native-giphy-keyboard`

### iOS

Add `use_frameworks!` to your Podfile under `target 'PROJECT_NAME' do`, then run `pod install` on your `ios` directory.

**Note:** for pure Objective-C projects, add an empty swift file to your project and choose Create the Bridging Header when prompted by Xcode. This allows static libraries to be linked.

Add your Giphy API key by adding this to your Info.plist:

```plist
<key>GiphyApiKey</key>
<string>YOUR_API_KEY_HERE</string>
```

### Android

Open your project build.gradle and add the following:

```gradle
buildscript {
    ext {
        kotlin_version = "1.3.61"
        ...
    }
    dependencies {
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        ...
    }
    ...
}

allprojects {
  repositories {
    maven {
        url "http://giphy.bintray.com/giphy-sdk"
    }
    ...
  }
  ...
}
```

Then go to your `android/app/src/main/res/values/strings.xml` and add the following key:

```xml
<string name="giphy_api_key">YOUR_API_KEY_HERE</string>
```

## API

### Open Giphy

```javascript
import * as GiphyKeyboard from 'react-native-giphy-keyboard';

GiphyKeyboard.openGiphy({
  rendition: 'fixedWidth',
  fileType: 'gif',
  mediaTypes: ['gifs', 'stickers'],
  theme: 'dark',
});
```

### Dismiss Giphy

```javascript
import * as GiphyKeyboard from 'react-native-giphy-keyboard';

GiphyKeyboard.dismiss();
```

### Listener

```javascript
import * as GiphyKeyboard from 'react-native-giphy-keyboard';

useEffect(() => {
  const removeListener = GiphyKeyboard.addMediaSelectedListener(media => {
    const { url, aspectRatio } = media;
  });

  return () => {
    removeListener();
  };
}, []);
```

## Example project

Feel free to clone this repo and run the `example/` project.

Run `npm install` or `yarn install` in the `example/` directory.

Run `pod install` in the `example/ios/` directory.

Build the app in XCode.