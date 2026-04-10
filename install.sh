#!/usr/bin/env bash
# Script Name: Arch Bootstrap - Melatonin Dotfiles
set -euo pipefail

# --- Console Colors ---
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly BLUE='\033[0;34m'
readonly YELLOW='\033[1;33m'
readonly NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[*] $1${NC}"; }
log_success() { echo -e "${GREEN}[+] $1${NC}"; }
log_warn() { echo -e "${YELLOW}[!] $1${NC}"; }
log_err() { echo -e "${RED}[x] $1${NC}" >&2; }

install_yay() {
    log_info "Checking for AUR Helper (yay)..."
    if ! command -v yay &> /dev/null; then
        log_warn "Yay is not installed. Cloning from AUR..."
        sudo pacman -S --needed --noconfirm git base-devel curl wget
        
        local tmp_dir
        tmp_dir=$(mktemp -d)
        git clone https://aur.archlinux.org/yay-bin.git "$tmp_dir"
        (cd "$tmp_dir" && makepkg -si --noconfirm)
        rm -rf "$tmp_dir"
        log_success "Yay has been successfully installed!"
    else
        log_success "AUR Helper (yay) is already installed."
    fi
}

install_packages() {
    log_info "Installing core system packages from official repo and AUR..."
    local pkgs=(
        "mangowm-git"
        "waybar"
        "fuzzel"
        "alacritty"
        "fish"
        "swaylock"
        "swaync"
        "matugen-bin"
        "swaybg"
        "wl-clipboard"
        "ttf-jetbrains-mono-nerd"
        "pamixer"
        "brightnessctl"
        "libnotify"
    )
    
    yay -S --needed --noconfirm "${pkgs[@]}"
    log_success "All dependencies installed successfully!"
}

setup_dotfiles() {
    log_info "Applying Melatonin Dotfiles to the system..."
    local repo_url="https://github.com/NirussVn0/Melatonin-dotfiles.git"
    local target_dir="/tmp/melatonin-dots"
    
    rm -rf "$target_dir"
    git clone "$repo_url" "$target_dir"
    
    log_info "Syncing ~/.config/ ..."
    mkdir -p ~/.config
    cp -r "$target_dir/.config/"* ~/.config/ 2>/dev/null || log_warn "Some directories already exist, performing safe overwrite..."
    
    log_success "Dotfiles applied successfully!"
}

change_shell() {
    log_info "Verifying default shell..."
    local fish_path
    fish_path=$(command -v fish)
    
    if [[ "$SHELL" != "$fish_path" ]]; then
        log_info "Changing default shell to fish (please enter your password if prompted)..."
        chsh -s "$fish_path"
        log_success "Default shell changed to fish (will take effect upon next login)."
    else
        log_success "Fish is already the default shell."
    fi
}

main() {
    clear
    echo -e "${YELLOW}====================================================${NC}"
    echo -e "${GREEN}      MELATONIN DOTFILES - ARCH BOOTSTRAP       ${NC}"
    echo -e "${GREEN}                 AUTHOR: NIRUSS                 ${NC}"
    echo -e "${YELLOW}====================================================${NC}"
    echo ""
    
    log_info "Updating system packages (pacman -Syu)..."
    sudo pacman -Syu --noconfirm
    
    install_yay
    install_packages
    setup_dotfiles
    change_shell
    
    echo ""
    echo -e "${YELLOW}====================================================${NC}"
    log_success "CONGRATULATIONS, SETUP IS COMPLETE!"
    log_info "Please logout, and once in TTY, type \e[1;31mmango\e[0m or \e[1;31mmangowm\e[0m to start."
    echo -e "${YELLOW}====================================================${NC}"
}

main "$@"
