# my nvim config
## Notes
### lua/options.lua
-- -- See `:help vim.opt`
-- NOTE: For more options, you can see `:help option-list`
### opts vs. config in lazy
The `opts` property should be used for straightforward plugin customizations where the plugin provides a setup function without having to write `require('plugin_name').setup({})`. It should be the same table passed directly to `require('plugin_name').setup({})`.
The config property is used for custom setup logic once the plugin loads, such as setting keymaps for the plugin or changing the colorscheme. You can technically run require('plugin_name').setup({}) here and it would work.
