import os

home = os.getenv("HOME")

links = {
        home + "/.dotfiles/bash_files/aliases": home + "/.bash_aliases",
        home + "/.dotfiles/bash_files/logout":  home + "/.bash_logout",
        home + "/.dotfiles/bash_files/rc":  home + "/.bashrc",
        home + "/.dotfiles/vim/":  home + "/.vim",
        home + "/.dotfiles/vim/vimrc":  home + "/.vimrc",
        home + "/.dotfiles/vim":  home + "/.config/nvim",
        }

for link in links:
    if os.path.exists(links[link]) or os.path.islink(links[link]):
        print("{0} already exists, overwrite it? (y/n)".format(links[link]))
        choice = input(">>>")
        if choice == "y":
            print("overwriting...")
            os.remove(links[link])
            os.symlink(link, links[link], True)
    else:
        os.symlink(link, links[link], True)
