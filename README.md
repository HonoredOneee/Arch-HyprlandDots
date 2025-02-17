
# 🚀 **Hyprland Installation Script**  

### 📌 **Descrição**  
Este release contém scripts automatizados para instalar e configurar o **Hyprland** no Arch Linux, com suporte para **AMD** e **Intel**. Ele inclui a instalação de pacotes essenciais, otimizações e configurações para um ambiente fluido e funcional.  

### ⚠️ **Avisos Importantes**  
⚠️ **Durante a instalação do Arch Linux via `archinstall`**, adicione os seguintes pacotes em **"Pacotes adicionais"**:  
   ```
   nano git base-devel fish
   ```  
⚠️ **Após a instalação, o Arch Linux perguntará se deseja entrar no `chroot`.** **Escolha `Yes`!**  
   - Se precisar entrar manualmente, use:  
     ```bash
     arch-chroot /mnt
     ```  

⚠️ **Edite o arquivo `/etc/makepkg.conf` para liberar todos os núcleos do processador:**  
   ```bash
   nano /etc/makepkg.conf
   ```  
   - Localize a linha `MAKEFLAGS="-j2"` e altere para:  
     ```bash
     MAKEFLAGS="-j$(nproc)"
     ```  
   - Salve e saia (`CTRL+X`, `Y`, `Enter`).  
   - **Reinicie o sistema:**  
     ```bash
     exit
     reboot
     ```  

---

### 🛠 **Após o Reboot**  
1️⃣ **Faça login no usuário criado durante a instalação.**  
2️⃣ **Digite o comando para iniciar o Fish:**  
   ```bash
   fish
   ```  
3️⃣ **Clone os arquivos do release diretamente:**  
   ```bash
   git clone --depth=1 --branch latest-release https://github.com/HonoredOneee/Arch-HyprlandDots.git  
   cd Arch-HyprlandDots  
   ```

---

### 🛠 **Recursos**  
✅ Suporte para **AMD** e **Intel** (detecção automática)  
✅ Instalação do **yay** e pacotes do **AUR**  
✅ Adição do repositório **Chaotic-AUR** Apenas no "Hypr-Cpu-Intel-and-Amd.sh"  
✅ Ativação de cores no **nano** e **pacman** Apenas no "Hypr-Cpu-Intel-and-Amd.sh"

✅ Configuração do **Hyprland**, Wayland e pacotes essenciais  
✅ Extração automática de configurações e wallpapers personalizados  

### 📂 **Arquivos no Release**  
📌 **`hypr-amd.sh`** - Script de instalação para sistemas AMD.  
📌 **`hypr-intel.sh`** - Script de instalação para sistemas Intel.  
📌 **`Hypr-Cpu-Intel-and-Amd.sh`** - Script unificado que detecta automaticamente o processador e instala os drivers apropriados.  
📌 **`config.zip`** - Arquivos de configuração pré-configurados para um setup otimizado.  
📌 **`wallpapers.zip`** - Pacote de wallpapers para personalizar o ambiente.  

---

### 📝 **Como Usar os Scripts**  
1️⃣ **Dê permissão de execução ao script escolhido:**  
   ```bash
   chmod +x hypr-amd.sh  
   chmod +x hypr-intel.sh  
   chmod +x Hypr-Cpu-Intel-and-Amd.sh  
   ```  
2️⃣ **Execute o script correspondente ao seu sistema:**  
   ```bash
   ./hypr-amd.sh  # Para AMD  
   ./hypr-intel.sh  # Para Intel  
   ./Hypr-Cpu-Intel-and-Amd.sh  # Para detecção automática  
   ```  

---

### 🛠 **Requisitos**  
✔️ Arch Linux instalado no **modo minimal**  
✔️ Pacotes adicionais (`nano git base-devel fish`) adicionados no `archinstall`  
✔️ **Aceitar a entrada no `chroot` quando perguntado pelo Arch Linux**  
✔️ Núcleos do processador liberados no `/etc/makepkg.conf`  
✔️ Conexão com a internet  
✔️ Usuário com privilégios sudo  

⚠️ **Aviso:** O script modifica arquivos do sistema, certifique-se de revisar o código antes de executar.  

### ✨ **Créditos**  
By **Rael/Discord:rael2pac and Aurelio/Discord:honored0nee**  
