local status_ok, pywal = pcall(require, "pywal")
if not status_ok then
	return
end

pywal.setup()

vim.cmd([[colorscheme pywal]])
