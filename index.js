import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNGiphyKeyboard } = NativeModules;
const EventEmitter = new NativeEventEmitter(RNGiphyKeyboard);

const MEDIA_SELECTED_EVENT = 'mediaSelected';
const DISMISSED_EVENT = 'giphyDismissed';

export function dismiss() {
  RNGiphyKeyboard.dismissGiphy();
}

export function openGiphy(options) {
  RNGiphyKeyboard.openGiphy(options);
}

export function addMediaSelectedListener(callback) {
  const listener = EventEmitter.addListener(MEDIA_SELECTED_EVENT, callback);

  return () => {
    listener.remove();
  }
}

export function addDismissedListener(callback) {
  const listener = EventEmitter.addListener(DISMISSED_EVENT, callback);

  return () => {
    listener.remove();
  }
}
