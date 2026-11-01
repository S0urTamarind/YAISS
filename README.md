<div align="center">

# YAISS
### *Yet Another Incremental Space Shooter*

[![Godot Engine](https://img.shields.io/badge/Godot-4.x-478CBF?logo=godotengine&logoColor=white)](https://godotengine.org)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)
[![Devlog](https://img.shields.io/badge/Docs-Devlog-brightgreen)](docs/DEVLOG.md)

An open-source experimental 2D space shooter built with Godot 4 and GDScript.

[Setup](#-setup--running-locally) • [Controls](#-current-controls) • [Project Structure](#-project-structure) • [Devlog](docs/DEVLOG.md)

</div>

---

> ⚠️ **Project Status: Early Pre-Alpha / In Active Development**  
> This is a learning-focused open-source project. Systems, controls, and scene hierarchies are actively evolving and are not yet in a playable release state.

---

## 🚀 Setup & Running Locally

### Prerequisites
* [Godot Engine 4.x (Standard Edition)](https://godotengine.org/download)

### Quickstart
1. Clone the repository:
   ```bash
   git clone [https://github.com/S0urTamarind/YAISS.git](https://github.com/S0urTamarind/YAISS.git)
   cd YAISS
   ```
2. Open Godot 4, click **Import**, and select the cloned folder.
3. Press the Play button to run the project.

---

## 🎮 Current Controls

| Action | Mapping | Description |
|---|---|---|
| **Aim Crosshair** | WASD or Arrow Keys | Move the orbiting sight around the player |
| **Shoot** | Space | Spawns projectiles toward the active sight position |

---

## 📁 Project Structure

```text
YAISS/
├── Assets/           # Art, textures, sprites, etc
├── Characters/       # Reusable scenes such as plater, crosshair, projectiles, etc
├── MainScenes/       # Level staging and gameplay arenas
├── docs/             # Running technical change history (DEVLOG.md)
├── src/              # Utility folder
└── project.godot     # Engine configuration and input action maps
```

---

## 📜 Development Log

Technical changes and system updates are documented via an automated workflow on every merged feature.  
Check out the running devlog in **[`docs/DEVLOG.md`](docs/DEVLOG.md)**.

---

## 📄 License

Distributed under the **GNU General Public License v3.0**. See [`LICENSE`](LICENSE) for details.