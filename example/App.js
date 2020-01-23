import React, {useEffect, useState} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  StatusBar,
  Button,
  NativeModules,
  NativeEventEmitter,
  Image,
  Keyboard,
} from 'react-native';

import {Colors} from 'react-native/Libraries/NewAppScreen';

const EventEmitter = new NativeEventEmitter(NativeModules.RNGiphyKeyboard);

const App = () => {
  const [selectedGif, setSelectedGif] = useState(null);

  useEffect(() => {
    EventEmitter.addListener('mediaSelected', media => {
      setSelectedGif(media);
      console.log(media);
      NativeModules.RNGiphyKeyboard.dismissGiphy();
    });
  }, []);

  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        {selectedGif && (
          <Image style={{width: '100%', aspectRatio: selectedGif.aspectRatio}} source={{uri: selectedGif.url}} />
        )}
        <Button
          title="Open Giphy!"
          onPress={() => {
            NativeModules.RNGiphyKeyboard.openGiphy({
              rendition: 'fixedWidth',
              fileType: 'gif',
              mediaTypes: ['gifs', 'stickers'],
              theme: 'dark'
            });
          }}
        />
      </SafeAreaView>
    </>
  );
};

const styles = StyleSheet.create({
  scrollView: {
    backgroundColor: Colors.lighter,
  },
  engine: {
    position: 'absolute',
    right: 0,
  },
  body: {
    backgroundColor: Colors.white,
  },
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
    color: Colors.black,
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
    color: Colors.dark,
  },
  highlight: {
    fontWeight: '700',
  },
  footer: {
    color: Colors.dark,
    fontSize: 12,
    fontWeight: '600',
    padding: 4,
    paddingRight: 12,
    textAlign: 'right',
  },
});

export default App;
