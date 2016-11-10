window.FUNK ?= {}

FUNK.templateHTML = (id, data = {})->

  tmpl = Handlebars.templates[id]
  if not tmpl
    throw new Error "Invalid template used: #{id}"

  output = tmpl(data)
  return output
