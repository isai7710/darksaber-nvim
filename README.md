## :flower_playing_cards: Introduction

# ![Mando with Darksaber](https://static0.gamerantimages.com/wordpress/wp-content/uploads/2023/02/the-darksaber-din-djarin-the-mandalorian-book-of-boba-star-wars-feature.jpeg)

Hi, thanks for checking out my nvim config. At the moment it's a tangled but useful mess of plugins that I'm constantly tinkering with. I'm a beginner when it comes to Neovim and its configuration, but the journey has been incredibly instructional. I've found that writing down certain notes along with the config has helped me understand what's going on much better, so pardon the messy comments in every module that attempt to explain the codes functionality. Lots of comments are left from the kickstart.nvim's repository configuration (huge shout out to TJDevries, watch his [videos](https://www.youtube.com/@teej_dv) for more Neovim and Lua guides), but I added some more explanation here and there. If anything is uncertain, let me know.

### How I installed Neovim from source on my WSL 2 environment running Ubuntu

1. Installed prerequisites: `sudo apt-get install ninja-build gettext cmake unzip curl build-essential`
2. Cloned the neovim repository into my `~/repos` folder: `git clone https://github.com/neovim/neovim ~/repos`
3. Ran `cd ~/repos/neovim` and checked out the stable branch with `git checkout stable`
4. I wanted Neovim installed in a specific directory, namely in my own `~/src` directory. Why? Idk haha I guess just to keep things organized. Also the neovim repo said installing in the default `/usr/local` directory can [complicate](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-source) uninstallation. Anyways, we have to build it first by running the following command with some cmake flags:

`make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim" CMAKE_BUILD_TYPE=RelWithDebInfo`

(Note you can change the build type here, I went with RelWithDebInfo, best of both worlds.)

5. Run the installation with `make install`
6. Add this line to your .bashrc file: `export PATH="$HOME/src/neovim/bin:$PATH"`
   and run `source .bashrc` to make the changes permanent.

Check everything is working by running `nvim --version`. You're output should look something like:

```
NVIM v0.10.0
Build type: RelWithDebInfo
LuaJIT 2.1.1713484068
Run "nvim -V1 -v" for more info
```

7. Now if you want some configuration files, create the config directory with `mkdir -p ~/.config/nvim` and either start writing your own lua configs or fork them from this repository or others if you want. Go crazy.

### Another quick note on Lua and Luarocks

Since I'm using lazy.nvim, one of the requirements is to have luarocks installed. Here's how I got the default installation of Lua and Luarocks under /usr/local:

1. Ensure you have the build prerequisites: `sudo apt install build-essential libreadline-dev unzip`
2. Run the following to build and install **Lua** (download package tar ball, extract, build and install) you can use wget too.

```
curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
tar -zxf lua-5.3.5.tar.gz
cd lua-5.3.5
make linux test
sudo make install
```

3. Run the following to build and install **Luarocks** (same deal as above but with wget, download and extract tar ball, build and install)

```
wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
tar zxpf luarocks-3.11.1.tar.gz
cd luarocks-3.11.1
./configure && make && sudo make install
```

Test you have both with `lua -v` and `luarocks --version`

## Additional notes on the config

### lazy.nvim package manager

[link](https://github.com/folke/lazy.nvim) to lazy.nvim's repo, huge shout out to folke. To enter the lazy UI simply execute `:Lazy`. You can check lazy's health with `:checkhealth lazy`

### Plugin Configuration with lazy.nvim

#### **The `opts` Property**

The `opts` property is used for simple and straightforward plugin configurations. It is a table that lazy.nvim automatically passes to the plugins setup function (`require("some_plugin").setup()`). This happens behind the scenes so you don't need to explicitly call the setup function yourself. The `opts` table is merged with the plugin's default options and is ideal for plugins that have a standard setup and don't require complex configurations.

#### **The `config` Property**

The `config` property is used for custom code or setup logic and finer control over plugin configurations too. It accepts a function that runs once the plugin loads. This property is useful for writing custom initialization logic, plugin-specific keymaps, autocommands, colorscheme changes, and more once the plugin loads. You can (and I think most plugins require you to) write require('plugin_name').setup({}) here to combine custom logic from before with standard configuration.

Alternatively, you can use both `opts` and `config` if necessary by conveniently passing the `opts` table into `config` like this:

    config = function(_, opts)
        require("some_plugin").setup(opts)
    end

## Some other helpful tips/commands

### the lazy lockfile

The lazy.lock.json file reflects the states of all the plugins in your config. If kept under version control, you can revert back to your old set up whenever things break after updating plugins. The command `:Lazy restore` will revert all the plugins to the state reflected in the current lockfile.
