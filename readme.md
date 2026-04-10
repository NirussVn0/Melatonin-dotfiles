# 🌙 Melatonin Dotfiles 

> A minimal, aesthetic, and immensely powerful working environment. Plug in and code, every keystroke is an art. (I use Arch, btw 🐧)

---

## 📸 Showcase

![Desktop Preview](assets/preview.png) 
![Term Preview](assets/preview.png)

---

## 🧩 Themed Components

*   **Compositor**: [MangoWC](https://github.com/Yjotsna/mangowc) - A flexible, lightweight, and incredibly stylish window manager.
*   **Theming Engine**: [Matugen](https://github.com/InioX/matugen) - Dynamic color generation mapping perfectly adapting to backgrounds using Material You concepts.
*   **Status Bar**: [Waybar](https://github.com/Alexays/Waybar) - Fully customizable, comprehensive system information with pixel-perfect CSS.
*   **Application Launcher**: [Fuzzel](https://codeberg.org/dnkl/fuzzel) - Lightning-fast execution, perfect native support for Wayland.
*   **Terminal**: [Alacritty](https://github.com/alacritty/alacritty) - GPU-rendered for zero latency typing. You type like you hack.
*   **Shell**: [Fish Shell](https://fishshell.com/) - Intelligent auto-suggestions directly out of the box without the hassle.
*   **Lockscreen**: [Swaylock](https://github.com/swaywm/swaylock) - Modern blur-styled lock screen.
*   **Notifications**: [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) - Control notifications like a real command center, full action center capabilities.
*   **System Monitor**: [btop](https://github.com/aristocratos/btop) - Monitor CPU, RAM, and Network with a cybernetic aesthetic.
*   **GTK**: Colors are applied seamlessly across GTK 2, 3, and 4 applications.

---

## 🚀 One-Click Install

No developer has the time to configure from stratch. The automated `install.sh` script is designed to be "Fail-fast" and POSIX-compliant, assuring your system doesn't break during the build.

> **⚠️ IMPORTANT NOTE:** Please ensure you are running on a fresh **Arch Linux** installation with fully updated packages.

### The Lazy Developer Way (Recommended)
Open your terminal from a bare-bones Arch OS, run this god-tier command and sip your tea:
```bash
curl -sSL https://raw.githubusercontent.com/NirussVn0/Melatonin-dotfiles/main/install.sh | bash
```

### The Pro-Control Way (Clone & Execute)
For those who trust no one but themselves and want to review the source code:
```bash
git clone https://github.com/NirussVn0/Melatonin-dotfiles.git
cd Melatonin-dotfiles
chmod +x install.sh
./install.sh
```

---

## ⚙️ Post-Installation Usage

- **Starting the Compositor:** The script will set up all parameters by default. Return to the `TTY` and type `mango` or `mangowm` to enter the GUI.
- **Built-in Tools (OSD & Media):** The system features a brilliant custom script located in `.config/osd-control.sh` that fires elegant pop-ups whenever you adjust the volume or screen brightness.
- **Dynamic Theming (Matugen):** The system automatically blends colors based on your chosen wallpaper to create a unified palette integrated directly into GTK and Waybar.

---

## Author: NirussVn0

*🙏 If this workspace has improved your workflow, please consider leaving a ⭐ to support the author!*

