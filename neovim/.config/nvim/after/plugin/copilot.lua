vim.cmd [[
  imap <silent><script><expr> <CR> copilot#Accept("")
  imap <silent><script><expr> <C-n> copilot#Next("")
  imap <silent><script><expr> <C-p> copilot#Previous("")
  let g:copilot_no_tab_map = v:true
]]
