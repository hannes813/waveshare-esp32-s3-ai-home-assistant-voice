# Home Assistant configuration notes

## Assist exposure

For every device you want to control:

```text
Settings → Voice assistants → Expose entity
```

Enable:

- Available to Assist
- Add aliases

Example alias:

```text
Licht Küche
Küchenlicht
```

## Pipeline test

Use Developer Tools or Assist debug:

```text
Schalte Küchenlicht ein
```

Expected flow:

```text
Wake word detected
STT started
Speech recognised as: ...
Intent started
Response: ...
Response URL: ...flac
Announcement finished playing
```

## German command hints

Good:

```text
Okay Nabu, schalte Küchenlicht ein
Okay Nabu, schalte Licht Küche ein
Okay Nabu, schalte Wohnzimmerlicht aus
```

Less robust:

```text
Okay Nabu, schalte Lichtküche ein
```

because STT may join words and Home Assistant then looks for an entity named `Lichtküche`.
