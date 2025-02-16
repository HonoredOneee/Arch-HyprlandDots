#!/bin/bash
# Hyprland e pacotes pós-instalação - By Rael and Aurelio

# Diretório base do script
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Diretório de trabalho para o yay-bin
WORKDIR="$HOME/yay-bin"

# Garantir que está no diretório HOME
cd "$HOME" || exit 1

# Função de pausa
pause() {
    sleep 5
}

# Função de tentativa de instalação com retry
retry_install() {
    package=$1
    for i in {1..3}; do
        if yay -S --noconfirm --needed "$package"; then
            echo "$package instalado com sucesso."
            break
        else
            echo "Erro ao instalar $package. Tentativa $i de 3..."
            pause
        fi
    done
}

# Perguntar ao usuário qual GPU ele usa
echo "Você está usando AMD ou Intel? (amd/intel)"
read -r GPU_TYPE

if [[ "$GPU_TYPE" == "amd" ]]; then
    mesa_packages=(
        mesa lib32-mesa mesa-utils vulkan-radeon lib32-vulkan-radeon
        llvm lib32-llvm vulkan-tools mesa-vdpau lib32-mesa-vdpau
        xf86-video-amdgpu 
    )
elif [[ "$GPU_TYPE" == "intel" ]]; then
    mesa_packages=(
        mesa lib32-mesa mesa-utils vulkan-intel lib32-vulkan-intel
        intel-media-driver lib32-intel-media-driver 
        xf86-video-intel 
    )
else
    echo "Opção inválida. Saindo..."
    exit 1
fi

# Clonar o repositório AUR se não existir
if [ ! -d "$WORKDIR" ]; then
    echo "Clonando o repositório yay-bin..."
    git clone https://aur.archlinux.org/yay-bin.git "$WORKDIR"
else
    echo "O repositório yay-bin já existe. Pulando clonagem."
fi

# Mudar para o diretório do repositório
cd "$WORKDIR" || exit 1

# Construir e instalar o pacote
echo "Executando makepkg -si..."
pause
makepkg -si --noconfirm

echo "Instalação do yay concluída!"

echo "Iniciando a instalação do Hyprland e pacotes - By Rael and Aurelio"
pause

packages=(
    hyprland dolphin dolphin-plugins kde-cli-tools kio unrar unrar-free unzip pacman-contrib kate oh-my-posh-bin epapirus-icon-theme
    code gnome-calculator papers loupe orchis-theme btop gnome-disk-utility gnome-text-editor gnome-calendar ark ksnip kitty
    waybar rofi waypaper wofi xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal-wlr
    archlinux-xdg-menu xdg-user-dirs xdg-user-dirs-gtk sddm nwg-look wl-clipboard clipman xorg polkit-gnome swww swaync swayidle
    network-manager-applet adw-gtk-theme alsa-utils pavucontrol ttf-ms-fonts grimblast-git swaylock-effects ffmpeg ffmpegthumbs
    ffmpegthumbnailer breeze breeze5 breeze-icons breeze-gtk qt5ct-kde qt6ct-kde wlogout
)

# Instalar pacotes com retry
for pkg in "${packages[@]}"; do
    retry_install "$pkg"
done

echo "Instalando pacotes gráficos para $GPU_TYPE..."
pause
for pkg in "${mesa_packages[@]}"; do
    sudo pacman -S --noconfirm --needed "$pkg"
done

echo "Instalando pacotes de fontes"
pause
sudo pacman -S --noconfirm ttf-font-awesome noto-fonts noto-fonts-emoji noto-fonts-extra ttf-firacode-nerd ttf-jetbrains-mono-nerd

echo "Instalando filesystem"
pause
fs_packages=(
    ntfs-3g exfat-utils dosfstools btrfs-progs xfsprogs jfsutils f2fs-tools reiserfsprogs nilfs-utils udftools e2fsprogs
)

for pkg in "${fs_packages[@]}"; do
    sudo pacman -S --noconfirm --needed "$pkg"
done

echo "Instalando wine e outros complementos"
pause
sudo pacman -S --noconfirm --needed wine winetricks wine-mono wine-gecko linux-lts-headers linux-zen-headers
retry_install protonup-qt-bin

echo "Deixando o Dolphin como gerenciador padrão"
pause
xdg-mime default org.kde.dolphin.desktop inode/directory

echo "Habilitando o SDDM no systemd"
pause
sudo systemctl enable sddm.service

echo "Ativando cores no pacman.conf..."
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf

echo "Ativando cores no nano..."
echo "include /usr/share/nano/*.nanorc" | sudo tee -a /etc/nanorc

echo "Verificando e extraindo config.zip para ~/.config..."
pause
if [ -f "$SCRIPT_DIR/config.zip" ]; then
    unzip -o "$SCRIPT_DIR/config.zip" -d "$HOME/.config"
    echo "Arquivo config.zip extraído para ~/.config com sucesso."
else
    echo "config.zip não encontrado no diretório do script ($SCRIPT_DIR)."
fi

echo "Verificando e extraindo Wallpapers.zip para ~/Imagens..."
pause
if [ -f "$SCRIPT_DIR/Wallpapers.zip" ]; then
    unzip -o "$SCRIPT_DIR/Wallpapers.zip" -d "$HOME/Imagens"
    echo "Arquivo Wallpapers.zip extraído para ~/Imagens com sucesso."
else
    echo "Wallpapers.zip não encontrado no diretório do script ($SCRIPT_DIR)."
fi

echo "Hyprland e pacotes instalados com sucesso."
pause

echo "Pressione Enter para reiniciar, ou CTRL+C para cancelar."
read -p ""

sudo reboot
