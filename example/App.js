import React, {useEffect, useState} from 'react';
import {
  SafeAreaView,
  StyleSheet,
  StatusBar,
  Button,
  Image,
  Keyboard,
} from 'react-native';
import * as GiphyKeyboard from 'react-native-giphy-keyboard';

import {Colors} from 'react-native/Libraries/NewAppScreen';

const App = () => {
  const [selectedGif, setSelectedGif] = useState(null);

  useEffect(() => {
    const removeListener = GiphyKeyboard.addMediaSelectedListener(media => {
      setSelectedGif(media);
      console.log(media);
      GiphyKeyboard.dismiss();
    });

    return () => {
      removeListener();
    };
  }, []);

  return (
    <>
      <StatusBar barStyle="dark-content" />
      <SafeAreaView>
        {selectedGif && (
          <Image
            style={{width: '100%', aspectRatio: selectedGif.aspectRatio}}
            source={{uri: selectedGif.url}}
          />
        )}
        <Button
          title="Open Giphy!"
          onPress={() => {
            GiphyKeyboard.openGiphy({
              rendition: 'fixedWidth',
              fileType: 'gif',
              mediaTypes: ['gifs', 'stickers'],
              theme: 'dark',
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
