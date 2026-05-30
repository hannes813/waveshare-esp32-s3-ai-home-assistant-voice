# Known bad / misleading configurations

These configurations were tested and are documented here to prevent others from repeating the same dead ends.

## ES8311-only microphone setup

Bad pattern:

```yaml
audio_dac:
  - platform: es8311
    use_microphone: true

microphone:
  - platform: i2s_audio
    i2s_din_pin: GPIO15
```

This can show microphone streaming and VAD activity, but STT may still fail because ES7210 is not configured.

## Random GPIO6/GPIO7/GPIO8 tests

GPIO6/GPIO7/GPIO8 can appear in board diagrams for LCD/shared functions. They are not the verified working microphone/speaker data pins for this setup.

Working data pins in this project:

```text
Mic DIN: GPIO15
Speaker DOUT: GPIO16
```

## Over-focusing on Whisper

If the iPhone Assist pipeline works but the ESP32 board does not, Whisper is not the primary problem. The issue is usually the ESP32 audio path.
