m = {}
function m.noremap(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, {noremap = true})
end

function m.nnoremap(lhs, rhs)
  m.noremap("n", lhs, rhs)
end

function m.inoremap(lhs, rhs)
  m.noremap("i", lhs, rhs)
end

function m.vnoremap(lhs, rhs)
  m.noremap("v", lhs, rhs)
end

function m.tnoremap(lhs, rhs)
  m.noremap("t", lhs, rhs)
end
return m

