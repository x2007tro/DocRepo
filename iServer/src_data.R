##
# Reactive source data
cmds_fb <- reactive({
  res <- ParseCmds(cmd_path, cmd_shts)
  return(res)
})

docs <- reactive({
  res <- ParseDocs(doc_path)
  return(res)
})