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

## Use Case

Primary use case:

BeamNG → Better_CAN → External CAN Gateway → Real Instrument Cluster

Thanks for offical docunment: https://documentation.beamng.com/modding/protocols/


---

## License

MIT License
