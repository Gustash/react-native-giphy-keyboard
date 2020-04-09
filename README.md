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
<string name="giphy_api_key" translatable="false">YOUR_API_KEY_HERE</string>
```

## Verification Mode

When you're ready to get a production key from Giphy, enable verification mode by doing the following:

### iOS

Add the following to your Info.plist and build the app.

```plist
<key>GiphyVerificationMode</key>
<true/>
```

### Android

Add the following to your `android/app/src/main/res/values/strings.xml` and build the app.

```xml
<bool name="giphy_verification_mode">true</bool>
```

Now follow the instructions on the Giphy Developers dashboard.

### Note

Remember to remove these when the verification is finished. You *DON'T* want this enabled when you ship to production.

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
