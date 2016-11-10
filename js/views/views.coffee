Backbone.View.prototype.close = ->
  this.remove()
  return

CreateTodo = Backbone.View.extend
  el: '#main-content',

  events:
    "click #submit-todo": "newTodo"

  initialize: ->
    @.render()
    return

  render: ->
    @$el.empty()
    output = FUNK.templateHTML('create_model')
    @$el.append output
    return

  newTodo: ()->
    id_num = Math.random() * 1000000
    id_num = Math.round(id_num)

    form_title = $('#form-title').val()
    form_time = $('#form-time').val()
    form_date = $('#form-date').val()

    if form_date.length > 0 and form_time.length > 0
      form_conc = form_date.concat(' ' + form_time)
      form_date = moment(form_conc).format('MM/DD/YYYY')
      form_time = moment(form_conc).format('h:mm a')


    console.log form_date
#    form_time = moment(form_time).format('h:mm')

    @.model.set 'title', form_title
    @.model.set 'date', form_date
    @.model.set 'time', form_time
    @.model.set 'id', id_num

    FUNK.Todos.add @.model
    todoRoutes.navigate "", true
    return


MyTodo = Backbone.View.extend {
  el: '#main-content'

  events:
    "click .todo-checkbox": "completeTodo"

  initialize: ()->
    @.render()
    return

  completeTodo: (e)->
#    e.preventDefault()
#    e.stopPropagation()
#    console.log @collection

    todo_id = $(e.currentTarget).parent().data('id')
    todo_model = @collection.where({id: todo_id})
    todo_model = todo_model[0].attributes
    todo_model['completed'] = true
    @.render()
    return

  displayTodos: ()->
    todo_arr = []
    if @collection
      @collection.each (todo)->
        obj = todo.attributes
        todo_arr.push obj
        return

    data =
      todos: todo_arr
    return data

  render: ->
#   .off() is unbinding events from other views.  Without it, we were getting 'zombie events'
#   delegateEvents() is turning on this view's specific events
    @$el.empty().off()
    @.delegateEvents()
    output = FUNK.templateHTML('my_todos', @.displayTodos())
    @$el.append output
    if @collection
      complete = @collection.where({completed: true})
      incomplete = @collection.where({completed: false})
#      console.log complete
    return
}


TodoRoutes = Backbone.Router.extend
  routes:
    "": "home"
    "new_todo": "newTodo"

  home: ->
    if FUNK.Todos.length > 0
      new MyTodo({collection: FUNK.Todos})
    else
      new MyTodo()
    return

  newTodo: ->
    new CreateTodo({model: new FUNK.TodoModel()})
    return

todoRoutes = new TodoRoutes()

Backbone.history.start()
