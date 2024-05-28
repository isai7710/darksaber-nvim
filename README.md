# my nvim config
## Notes
### lua/options.lua
-- -- See `:help vim.opt`
-- NOTE: For more options, you can see `:help option-list`
### opts vs. config in lazy
The `opts` property should be used for straightforward plugin customizations. It is a table that gets automatically passed to the plugins setup function `require("some_plugin").setup()` without the need of writing it out AND if the config property is not set

The `config` property is used for custom setup logic and possible plugin configurations too. Note however that this executes ONCE the plugin loads. This is useful for setting keymaps for the plugin or changing the colorscheme or something else ONCE the plugin loads. You can technically run require('plugin_name').setup({}) here and pass in some plugin customizations and it would work too. 

Alternatively, if `config` and `opts` are set, you can conveniently pass the `opts` table into `config` and use it to further configure the plugin like this:

config = function(_, opts)
    ...
    require("some_plugin").setup(opts)
end
