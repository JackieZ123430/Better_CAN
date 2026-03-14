# Better_CAN

Better_CAN is a structured telemetry-to-CAN bridge for BeamNG.drive, designed for real automotive instrument cluster simulation.

Unlike OutGauge, Better_CAN provides a versioned, extensible protocol with semantic vehicle state mapping.

---

## Motivation

The original OutGauge protocol is limited in structure and does not expose modern vehicle control states such as:

- P/R/N/D gear letters
- Separate ABS / ESC / TCS availability and activity
- Individual lighting signals
- Expandable protocol fields

Better_CAN replaces numeric and bitmask-heavy structures with explicit state fields to improve integration with real hardware (e.g., BMW F-series clusters).

---

## Features

- Structured CAN-style telemetry output
- Gear letter mapping (P / R / N / D)
- Independent light signal flags
- Separate stability system states
- Versioned protocol header
- Designed for external hardware integration (ESP32 / CAN gateway)

---

## Protocol Design

The protocol is versioned and extensible.

Example structure (v1):

- Version
- RPM
- Speed
- Gear Letter
- ABS / ESC / TCS states
- Light indicators
- (Expandable fields)

See `/docs/protocol_v1.md` for full specification.

---

## Compatibility

Better_CAN is **NOT compatible with OutGauge**.

It is designed as a modern alternative for structured vehicle state transmission.

---


## Installation / Deployment

1. Download or clone this repository.

2. Extract the folder **BMW_CAN_PROTO** into the BeamNG unpacked mods directory.

If the `unpacked` directory does not exist, create it manually.

Correct path: AppData\Local\BeamNG\BeamNG.drive\current\mods\unpacked\BMW_CAN_PROTO\lua\vehicle\protocols

The final structure should look like this:

BeamNG.drive
└── mods
    └── unpacked
        └── BMW_CAN_PROTO
            └── lua
                └── vehicle
                    └── protocols
                        └── BMW_CAN.lua

3. Open `BMW_CAN.lua` and modify the **IP address** to match the IP of your ESP32 CAN gateway.

Example: local udpIP = "192.168.1.100"
Replace it with the IP address of your hardware controller.

4. Launch BeamNG.drive and select the **BMW_CAN protocol**.

Telemetry will then be streamed to the external CAN gateway.

---

## Integration with CarCluster-F10-Enhanced

This project is designed to work together with the ESP32 firmware project:

https://github.com/JackieZ123430/CarCluster-F10-Enhanced

Typical architecture:

BeamNG → Better_CAN → UDP → ESP32 → CAN → BMW Instrument Cluster

The ESP32 firmware receives telemetry data and converts it into the CAN frames required by BMW F-series instrument clusters.

---

---

## Debug / Reload

BeamNG provides a console that can be used to verify that the protocol has been loaded correctly.

Press `~` to open the in-game console and view Lua logs.

If the protocol is loaded successfully, log messages related to `BMW_CAN` should appear.

After modifying the Lua script, press:

CTRL + R

to reload the vehicle and load the updated Lua script without restarting the game.

## License

MIT License
