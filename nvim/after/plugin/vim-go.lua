vim.g.go_term_mode = "split"
vim.g.go_fmt_command = "goimports"
vim.g.syntastic_go_checkers = {
    'errcheck',
    'gosimple',
    'govet',
    'ineffassign',
    'staticcheck',
    'typecheck',
    'unused',
}

vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1

vim.g.go_doc_keywordprg_enabled = 0

vim.g.go_list_type = 'quickfix'
vim.g.go_def_mapping_enabled = 0
vim.g.go_def_mode = 'gopls'
vim.g.go_info_mode = ('gopls')

vim.g.go_gorename_prefill = ''
