
// ** Model **
var Item = Backbone.Model.extend({
  defaults: {
    task: '',
    due_date: ''
  }
});


// ** View **
var ItemView = Backbone.View.extend({
  initialize: function() {
    this.listenTo(this.model, 'remove', this.remove)
  }, 
  events: {
    "click #destroy" : 'destroy'
  },

  tagName: 'li',

  template: _.template( $('#itemview-template').html() ),

  render: function(){
    this.$el.html( this.template( this.model.attributes ) );
    return this;
  },
  destroy: function(e){
    e.preventDefault();
    this.model.destroy();
  }
});


// ** Collection **
var ItemCollection = Backbone.Collection.extend({

  url: '/items', 
  initialize: function(){
    this.fetch();
  },
  model: Item 

});


// ** View **
var ItemListView = Backbone.View.extend({
  initialize: function(){
    this.listenTo(this.collection, 'add', this.renderItem)
  },
  renderItem: function(item){
      item.view = new ItemView({ model: item });
      this.$el.prepend( item.view.render().el );
      return this;
  },
  render: function(){
    var self = this;
    this.$el.empty();
    _.each(this.collection.models, function(item){
      self.renderItem(item);
    });
  }
});


// ** View **
var ItemFormView = Backbone.View.extend({
  events: {
    'submit':'submitCallback'
  },
  submitCallback: function(e){
    e.preventDefault();
    var item_data = this.getFormData();
    this.collection.create(item_data);
    this.clearForm();
  },
  getFormData: function(){
    var item_data = {
      task: this.$('#task-field').val(),
      due_date: this.$('#due-date-field').val()
    };
    return item_data
  },
  clearForm: function() {
      this.$('input').val('')
  }
});


var item_collection, item_list_view, item_form_view;


$(function(){

  item_collection = new ItemCollection();
  item_list_view = new ItemListView({collection: item_collection, el: $('#todo-list')});
  item_form_view = new ItemFormView({collection: item_collection, el: $('#item-form')})

});

