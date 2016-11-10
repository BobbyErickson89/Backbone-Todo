window.FUNK ?= {}

FUNK.TodoModel = Backbone.Model.extend
  defaults:
    "title": "Untitled"
    "date": ""
    "time": ""
    "completed": false

FUNK.TodoCollection = Backbone.Collection.extend
  model: FUNK.TodoModel

FUNK.Todos = new FUNK.TodoCollection()