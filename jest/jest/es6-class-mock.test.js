const SoundPlayer = require('./SoundPlayer');
const SoundPlayerConsumer = require('./sound-player-consumer');

jest.mock('./SoundPlayer');

beforeEach(() => {
  SoundPlayer.mockClear();
});

test('SoundPlayerConsumer 能被实例化', () => {
  const soundPlayerConsumer = new SoundPlayerConsumer();
  expect(soundPlayerConsumer).toBeTruthy();
});

test('构造时会 new SoundPlayer', () => {
  const soundPlayerConsumer = new SoundPlayerConsumer();
  expect(SoundPlayer).toHaveBeenCalledTimes(1);
  expect(soundPlayerConsumer).toBeTruthy();
});

test('playSomethingCool 会调用 playSoundFile', () => {
  const soundPlayerConsumer = new SoundPlayerConsumer();
  const mockPlay = SoundPlayer.mock.instances[0].playSoundFile;

  soundPlayerConsumer.playSomethingCool();

  expect(mockPlay.mock.calls[0][0]).toEqual('song.mp3');
  expect(mockPlay).toHaveBeenCalledWith('song.mp3');
});
