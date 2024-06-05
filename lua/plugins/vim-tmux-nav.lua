--[[
This plugin provides the following mappings which allow you to move between Vim panes and tmux splits seamlessly.
<ctrl-h> => Left
<ctrl-j> => Down
<ctrl-k> => Up
<ctrl-l> => Right
<ctrl-\> => Previous split
Note - you don't need to use your tmux prefix key sequence before using the mappings.
--]]
return {
  'christoomey/vim-tmux-navigator',
}
