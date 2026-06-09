# OM302DConsole

Graphical user interface for the **Sedecal OM302D** medical ozone therapy device. Built with Qt/QML and C++ for embedded ARM Linux.

---

## Target platform

| Item | Details |
|---|---|
| Hardware | Freescale iMX6 (ARM Cortex-A9, 32-bit) |
| OS | Embedded ARM Linux, no X11 desktop environment |
| Rendering | Direct EGL framebuffer with Vivante GPU |
| Deployment path | `/opt/OM302DConsole/` |

---

## Build requirements

- **Qt 5.12.6** with cross-compilation support for `arm-linux-gnueabihf`
- **Qt Creator 4.x** or later
- **Toolchain:** `arm-linux-gnueabihf-g++`
- **Sysroot:** iMX6 device sysroot with Vivante EGL/OpenGL ES libraries

---

## Build instructions

```bash
qmake OM302DConsole.pro
make -j$(nproc)
```

---

## Deployment

Copy the compiled binary and all resource folders to the target device:

```bash
scp OM302DConsole user@device:/opt/OM302DConsole/
scp -r Images/ ImgDB/ Documents/ Singletons/ user@device:/opt/OM302DConsole/
```

The hardware control daemon must be listening on `localhost:15557` before launching the UI.

---

## Optional media assets

The `Videos/` and `Tutorials/` directories are not included in this repository due to their size (~300 MB). They are available as downloadable archives attached to each [GitHub Release](https://github.com/sedecal/OM302DConsole/releases):

```
OM302DConsole-videos-vX.Y.Z.tar.gz     → extract as Videos/
OM302DConsole-tutorials-vX.Y.Z.tar.gz  → extract as Tutorials/
```

To install, run from the project root (next to `OM302DConsole.pro`):

```bash
tar -xzf OM302DConsole-videos-vX.Y.Z.tar.gz
tar -xzf OM302DConsole-tutorials-vX.Y.Z.tar.gz
```

The application builds and runs correctly without these files; demo videos and in-app tutorials will simply not be available on the device.

---

## Version

`V0.R0.P4`

---

## License

This project is licensed under the **GNU General Public License v3.0 or later**. See [`LICENSE`](LICENSE) for the full text.

Third-party acknowledgements are listed in [`NOTICE`](NOTICE).

---

## Medical device notice

> This software controls a certified medical device. Clinical use requires the applicable regulatory certifications and authorisations in each country. **Sedecal S.A. accepts no liability for use outside the certified configuration.**

---

## Contact

[www.sedecal.com](https://www.sedecal.com)
