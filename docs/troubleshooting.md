# Troubleshooting

## Wake word works, but STT returns no text

Check whether ES7210 is initialized.

Good log:

```text
ES7210 audio ADC:
  Bits Per Sample: 16
  Sample Rate: 16000
```

Bad sign:

```text
ES8311 Audio Codec:
  Use Microphone: YES
```

on its own without ES7210. The ES8311 is not the microphone ADC for this board.

## `stt-no-text-recognized`

If logs show:

```text
STT started
STT by VAD end
Error: stt-no-text-recognized
```

then audio activity exists, but the speech signal is not usable. On this board this was caused by missing ES7210 initialization.

## Wake word triggers while the assistant is listening

If `Okay Nabu` is detected again during `AWAITING_RESPONSE`, it can stop the current pipeline. Wait until the wake chime/status light, then speak only the command.

## Entity not found

Example:

```text
Response: "Lichtküche existiert nicht"
```

Fix: add a better alias, for example:

```text
Küchenlicht
Licht Küche
```

## Previous boot crash

A crash like:

```text
CRASH DETECTED ON PREVIOUS BOOT
Reason: Fault - LoadProhibited
APIServer::on_log
```

was seen while running heavy debug/logging and scripts. Reduce logging verbosity for stable operation.

Recommended production logger:

```yaml
logger:
  level: DEBUG
```

Avoid `VERY_VERBOSE` long-term.
