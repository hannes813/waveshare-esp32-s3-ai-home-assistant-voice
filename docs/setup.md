# Setup

## 1. Flash ESPHome firmware

Use the YAML in:

```text
esphome/hivicon-voice-wohnzimmer.yaml
```

The important working parts are:

```yaml
audio_adc:
  - platform: es7210
    id: adc_mic
```

and:

```yaml
audio_dac:
  - platform: es8311
    id: es8311_dac
```

## 2. Connect to Home Assistant

After flashing, Home Assistant should discover the ESPHome device automatically.

## 3. Select Assist pipeline

Use a German pipeline if your commands are German.

Recommended:

- Wake word: `Okay Nabu`
- STT: Wyoming Whisper / German
- Conversation agent: Home Assistant
- TTS: Piper or Home Assistant Cloud

## 4. Entity aliases

Speech recognition works better when aliases are natural.

Recommended examples:

```text
Küchenlicht
Licht Küche
Wohnzimmerlicht
Stehlampe
```

Avoid relying only on technical entity IDs like:

```text
switch.homematic_schalter_oeq0181620
```
