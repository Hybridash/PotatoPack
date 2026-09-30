# 🥔 PotatoPack

**Makes Minecraft run as fast as possible on low-end PCs.** It's vanilla Minecraft with the same gameplay and no new blocks, just a lot more FPS.

- Minecraft **1.21.1** · Fabric
- Works in **Prism Launcher**, **Modrinth App**, ATLauncher, and anything else that imports `.mrpack`
- Updates itself when you launch it (optional, see below)

## How fast?

It depends on your hardware, so there's no single number. Typical results with Sodium-based packs compared to vanilla:

| PC | Vanilla | PotatoPack (defaults) |
|---|---|---|
| Old laptop, Intel HD integrated graphics, 4 GB RAM | 20–40 FPS | 60–120 FPS |
| Budget PC, any GPU from the last ~8 years | 60–100 FPS | 150–300+ FPS |

**Want 200+ on a weak PC?** Lower **Render Distance** to 4–6. That's the setting that matters most. After that, use Video Settings → **Extras** (from Sodium Extra) to turn off fog, animations, and particles.

## What's inside

| Mod | What it does |
|---|---|
| Sodium | New renderer, the biggest FPS boost |
| Sodium Extra + Reese's Sodium Options | More toggles and a cleaner settings menu |
| ImmediatelyFast | Faster HUD, text, and entity drawing |
| Entity Culling / More Culling | Skips drawing things you can't see |
| BadOptimizations | Stops re-computing sky, fog, and lighting every frame |
| Lithium | Faster game logic (mobs, physics, redstone) |
| C2ME | Loads chunks on all CPU cores |
| ScalableLux | Faster lighting |
| Krypton | Lighter networking |
| FerriteCore / ModernFix / MemoryLeakFix | Less RAM use and faster startup |
| Dynamic FPS | Pauses rendering when the game is minimized |
| Mod Menu | Lists your mods in-game with settings buttons |
| Iris *(optional, off)* | Shaders, only if your PC can handle them |

The pack starts with potato settings: render distance 6, Fast graphics, no clouds, no VSync, and minimal particles. These **only apply the first time**, so changing them later is fine and they won't get reset.

## Install

### Easy way (any launcher)
1. Go to [**Releases**](../../releases) and download `PotatoPack.mrpack`.
2. **Prism Launcher:** Add Instance → Import → choose the file.
   **Modrinth App:** drag the file into the window.
3. Play.

### Auto-updating way (Prism Launcher)
With this setup, the pack updates itself every time you hit Play.
1. Download [`packwiz-installer-bootstrap.jar`](https://github.com/packwiz/packwiz-installer-bootstrap/releases) and put it in the instance's `minecraft` folder (Right-click instance → Folder).
2. Right-click the instance → Edit → Settings → Custom commands → tick it, and set **Pre-launch command** to:
   ```
   "$INST_JAVA" -jar packwiz-installer-bootstrap.jar https://raw.githubusercontent.com/Hybridash/PotatoPack/main/pack.toml
   ```

### RAM setting
Don't give Minecraft too much RAM. On a potato, more RAM can make it *slower*.
- 4 GB PC → **2048 MB**
- 8 GB PC → **3072 MB**
- 16 GB+ → **4096 MB**

(Prism: Edit → Settings → Java → Maximum memory allocation.)

## Managing the pack (for you, the pack maker)

Everything is controlled by **`mods.txt`**, which has one Modrinth mod per line.

- **Add a mod:** add its Modrinth slug (the last part of its URL, like `modrinth.com/mod/`**`sodium`**) to `mods.txt` and push. GitHub Actions adds it and builds a new `.mrpack`.
- **Remove a mod:** delete the line in `mods.txt`, the mod's file in `mods/`, and its line in `scripts/added.txt`.
- **Update all mods:** this happens automatically every Monday. You can also run it anytime from the **Actions** tab → Build PotatoPack → Run workflow.
- **Make a release:** bump `version` in `pack.toml`, then create a tag like `v1.0.1` (Releases → Draft new release → new tag). The `.mrpack` gets attached automatically.
- **Change Minecraft version:** edit `minecraft =` and `fabric =` in `pack.toml`, then run `packwiz migrate minecraft <version>` locally, or delete `mods/` and `scripts/added.txt` and let Actions re-add everything.

### Working locally (optional)
```bash
go install github.com/packwiz/packwiz@latest
bash scripts/sync-mods.sh          # add everything from mods.txt
packwiz modrinth export            # build the .mrpack
```

## Credits
Built with [packwiz](https://packwiz.infra.link/). Every mod belongs to its authors. This pack only links to the downloads on Modrinth.
