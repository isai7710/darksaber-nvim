# my nvim config

## A brief word

I have included lots of comments that try to explain the code for each configuration Lua module. Lots of comments are left from the kickstart.nvim's repository configuration (huge shout out to TJDevries, watch his [videos](https://www.youtube.com/@teej_dv) for more Neovim and Lua guides), but I added some more explanation here and there. If anything is uncertain, let me know.

### How I installed Neovim from source on my WSL 2 environment (specifically running a Ubuntu distribution)

1. Installed prerequisites: `sudo apt-get install ninja-build gettext cmake unzip curl build-essential`
2. Cloned the neovim repository into my `~/repos` folder: `git clone https://github.com/neovim/neovim ~/repos`
3. Ran `cd ~/repos/neovim` and checked out the stable branch with `git checkout stable`
4. I wanted Neovim installed in a specific directory, namely in my own `~/src` directory. Why? Idk haha I guess just to keep things organized. Also the neovim repo said installing in the default `/usr/local` directory can [complicate](https://github.com/neovim/neovim/blob/master/INSTALL.md#install-from-source) uninstallation. Anyways, we have to build it first by running the following command with some cmake flags:

`make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim" CMAKE_BUILD_TYPE=RelWithDebInfo`

Note you can change the build type here, I went with RelWithDebInfo, best of both worlds.

5. Run the installation with `make install`
6. Add this line to your .bashrc file: `export PATH="$HOME/src/neovim/bin:$PATH"`
   and run `source .bashrc` to make the changes permanent.

Now if you run `nvim --version` you should get an output like this

```
NVIM v0.10.0
Build type: RelWithDebInfo
LuaJIT 2.1.1713484068
Run "nvim -V1 -v" for more info
```

7. Now if you want some configuration files, create the config directory with `mkdir -p ~/.config/nvim` and either start writing your lua configs or fork them from mine if you want. Go crazy.

## Additional Notes

### lua/options.lua

-- -- See `:help vim.opt`
-- NOTE: For more options, you can see `:help option-list`

### opts vs. config in lazy

The `opts` property should be used for straightforward plugin customizations. It is a table that gets automatically passed to the plugins setup function `require("some_plugin").setup()` without the need of writing it out AND if the config property is not set

The `config` property is used for custom setup logic and possible plugin configurations too. Note however that this executes ONCE the plugin loads. This is useful for setting keymaps for the plugin or changing the colorscheme or something else ONCE the plugin loads. You can technically run require('plugin_name').setup({}) here and pass in some plugin customizations and it would work too.

Alternatively, if `config` and `opts` are set, you can conveniently pass the `opts` table into `config` and use it to further configure the plugin like this:

    config = function(_, opts)
        require("some_plugin").setup(opts)
    end
