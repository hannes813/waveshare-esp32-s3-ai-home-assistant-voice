# Hardware notes

## Board architecture

The board is not a simple ESP32 with a generic I2S microphone.

It contains:

- ES7210: microphone ADC
- ES8311: DAC/speaker codec
- TCA9555: GPIO expander for keys/amplifier
- WS2812 LED ring on GPIO38

## Working audio path

```text
Microphones → ES7210 → I2S DIN GPIO15 → ESP32-S3 → Home Assistant Assist
Home Assistant TTS → ESP32-S3 → I2S DOUT GPIO16 → ES8311 → amplifier/speaker
```

## Why ES8311-only is not enough

ES8311 can be initialized and logs can look healthy, but that does not prove that the microphone path is correct.

The microphone ADC must be initialized separately through ES7210.
