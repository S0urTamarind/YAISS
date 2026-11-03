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
> This is a learning-focused open-source project. Core movement, mouse aiming, a basic weapon system, projectiles, and a scrolling starfield are currently implemented. Systems, balance, and scene hierarchies are still evolving.

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

The configured main scene is `MainScenes/Gameplay.tscn`. The project currently targets a 1920×1080 viewport and uses Godot's GL Compatibility renderer.

---

## 🎮 Current Controls

| Action | Mapping | Description |
|---|---|---|
| **Move** | `W` `A` `S` `D` | Move the player up, left, down, and right |
| **Aim** | Mouse movement | Move the captured mouse crosshair around the gameplay area |
| **Shoot** | Hold `Space` | Fire the equipped weapon toward the crosshair |

The mouse is captured when gameplay starts so relative mouse movement can be used for aiming. The crosshair is constrained to the visible gameplay area.

---

## 📁 Project Structure

```text
YAISS/
├── Assets/
│   ├── notebookBg.png        # Custom project artwork
│   ├── star.png              # Custom project artwork
│   └── SpaceShooter_Assets/  # Legacy online asset pack being phased out
├── Characters/
│   ├── Background.tscn        # Space background and starfield
│   ├── Bullet.tscn            # Projectile scene
│   ├── Player.tscn            # Player scene
│   ├── Sights.tscn            # Mouse-controlled aiming crosshair
│   ├── bullet.gd
│   ├── player.gd
│   └── sights.gd
├── MainScenes/
│   └── Gameplay.tscn          # Main gameplay scene
├── docs/
│   ├── DEVLOG.md              # Development history
│   └── IMAGE_OPTIMIZATION.md  # Image optimization notes
├── src/yaiss/
│   ├── geometry.gd            # Collision and geometry helpers
│   ├── logging.gd             # Shared logging utility
│   ├── runtime.gd             # Runtime error and fatal-error helpers
│   └── weapons/               # Weapon abstractions and default weapon
└── project.godot               # Engine configuration and input action map
```

---

## 📜 Development Log

Technical changes and system updates are documented in the running devlog.
Check out **[`docs/DEVLOG.md`](docs/DEVLOG.md)** for implementation history.

---

## 📄 License

Distributed under the **GNU General Public License v3.0**. See [`LICENSE`](LICENSE) for details.