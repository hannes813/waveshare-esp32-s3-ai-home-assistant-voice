# HiViCon Voice Assistant – Waveshare ESP32-S3 AI Smart Speaker Development Board for Home Assistant Assist

Local voice satellite for Home Assistant Assist based on the Waveshare ESP32-S3-AUDIO-Board.

This repository documents a working configuration for the board variant with:

- ESP32-S3R8
- ES7210 microphone ADC
- ES8311 speaker/DAC codec
- TCA9555 GPIO expander
- WS2812 RGB LED ring
- Home Assistant Assist
- local wake word detection via `micro_wake_word`
- local STT via Wyoming Whisper
- optional local TTS via Wyoming Piper

The key finding: **the microphone path must use the ES7210 ADC.** A plain `i2s_audio` microphone plus ES8311-only setup can stream data but does not provide usable speech recognition on this board.

## Status

Working:

- Wake word detection: `Okay Nabu`
- ES7210 microphone ADC
- ES8311 speaker output
- I2S pins verified
- Home Assistant Assist pipeline
- STT recognition
- local response playback
- RGB status ring
- onboard keys via TCA9555

Example confirmed recognition:

```text
Speech recognised as: " Schalte Lichtküche ein."
Response: "Lichtküche existiert nicht"
```

The response was semantically correct: Home Assistant understood the command but did not find an entity with that alias.

## Hardware

Tested board:

```text
Waveshare ESP32-S3-AUDIO-Board
ESP32-S3R8
ES7210 microphone ADC
ES8311 audio codec
TCA9555 GPIO expander
```

Verified important pins:

| Function | Pin / Bus |
|---|---:|
| I2C SDA | GPIO11 |
| I2C SCL | GPIO10 |
| I2S MCLK | GPIO12 |
| I2S BCLK | GPIO13 |
| I2S LRCLK | GPIO14 |
| Microphone data input | GPIO15 |
| Speaker data output | GPIO16 |
| RGB LED ring | GPIO38 |
| Amplifier control | TCA9555 pin 8 |
| Key1 | TCA9555 pin 9 |
| Key2 | TCA9555 pin 10 |
| Key3 | TCA9555 pin 11 |

Detected I2C devices:

| Address | Likely component |
|---:|---|
| `0x18` | ES8311 |
| `0x20` | TCA9555 |
| `0x40` | ES7210 |
| `0x51` | RTC / board peripheral |

## Repository structure

```text
.
├── esphome/
│   └── hivicon-voice-wohnzimmer.yaml
├── docker/
│   ├── docker-compose.yml
│   ├── wyoming-whisper.sh
│   └── wyoming-piper.sh
├── docs/
│   ├── setup.md
│   ├── home-assistant.md
│   ├── troubleshooting.md
│   ├── hardware-notes.md
│   └── known-bad-configs.md
└── logs/
```

## Quick start

1. Copy `esphome/hivicon-voice-wohnzimmer.yaml` into your ESPHome config folder.
2. Add your Wi-Fi and API secrets in ESPHome secrets.
3. Compile and flash the board.
4. Install Wyoming Whisper for local STT.
5. Optional: install Wyoming Piper for local TTS.
6. Add the ESPHome device in Home Assistant.
7. Configure Assist aliases for the entities you want to control.

## ESPHome secrets

Example:

```yaml
wifi_ssid: "YOUR_WIFI"
wifi_password: "YOUR_WIFI_PASSWORD"
api_encryption_key: "YOUR_ESPHOME_API_KEY"
ota_password: "YOUR_OTA_PASSWORD"
```

## Required Home Assistant components

- ESPHome integration
- Assist pipeline
- Wyoming Protocol integration
- Wyoming Whisper for speech-to-text
- Optional Wyoming Piper for text-to-speech

## Local Whisper Docker

```bash
docker run -d \
  --name wyoming-whisper \
  --restart unless-stopped \
  --network host \
  rhasspy/wyoming-whisper \
  --model tiny \
  --language de
```

Then in Home Assistant:

```text
Settings → Devices & services → Add integration → Wyoming Protocol
Host: <docker-host-ip>
Port: 10300
```

## Local Piper Docker

```bash
docker run -d \
  --name wyoming-piper \
  --restart unless-stopped \
  -p 10200:10200 \
  -v /volume1/docker/piper:/data \
  rhasspy/wyoming-piper \
  --voice de_DE-thorsten-high
```

Then in Home Assistant:

```text
Settings → Devices & services → Add integration → Wyoming Protocol
Host: <docker-host-ip>
Port: 10200
```

## Important lesson learned

The ES8311 is not the microphone ADC on this board. It is the DAC/speaker codec.

The working setup requires:

```yaml
audio_adc:
  - platform: es7210
```

Without ES7210 initialization, wake/STT may appear partially alive, but Whisper receives unusable audio.

## License

MIT License. See `LICENSE`.
