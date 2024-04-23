require("sg").setup {
	enable_cody = true,
	event = "InsertEvent",
  -- Pass your own custom attach function
  --    If you do not pass your own attach function, then the following maps are provide:
  --        - gd -> goto definition
  --        - gr -> goto references
  -- on_attach = your_custom_lsp_attach_function
}
