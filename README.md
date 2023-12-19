# Monokai Pro Theme for TMUX

Elevate your tmux experience with the Monokai Pro theme – a vibrant and sleek color scheme inspired by the popular Monokai Pro palette.

![tmux-showcase](https://github.com/loctvl842/monokai-pro.tmux/assets/80513079/93a7e03c-4bad-4c6c-ac87-33209a0c6d1c)

## Installation

### Using Tmux Plugin Manager (TPM)

1. Make sure you have TPM installed. If not, follow the [TPM installation instructions](https://github.com/tmux-plugins/tpm#installation).

2. Add the following line to your `tmux.conf` to install Monokai Pro theme with TPM:
    ```bash
    set -g @plugin 'loctvl842/monokai-pro.tmux'
    ```

3. Press `prefix` + `I` inside a tmux session to install the plugin.

### Manual

1. Clone or download the Monokai Pro tmux theme repository.
    ```bash
    git clone https://github.com/your-username/monokai-pro-tmux.git
    ```

2. Copy the theme's configuration contents (file `monokai-pro.tmux`) into your Tmux config file. (usually `~/.tmux.conf`)

3. Reload your tmux configuration for the changes to take effect.
    ```bash
    tmux source-file ~/.tmux.conf
    ```

## Customization

Feel free to tweak the theme to match your preferences. Adjust color variables in the theme file for a personalized Monokai Pro experience that suits your unique style.

## Contributing

Contributions are welcome! If you have ideas for improvements or new features, feel free to open an issue or submit a pull request.
