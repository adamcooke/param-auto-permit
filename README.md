# Param Auto Permit

This is a library to allow you to automatically allow permitted
fields to be passed through to your models from forms without
needing to list every accepted field in your controller.

You may be familiar with something like this:

```ruby
User.create(params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation))
```

It's a bit of a pain to need to list every permitted attribute in your
controller when you had already provided that data in your form.
Plus, you may need to add additional logic to protect certain
fields. Again, this logic was likely already present in your
view so why duplicate in the controller?

Using this gem, you can simply do this and all the fields which
were included in the your form will be securely permitted.

```ruby
User.create(params.require(:user).permit(:_auto))
```

## How does it work?

Whenever you build a form using the Rails form builder options (e.g
using `form_for`), the gem maintains a list of included fields based
on their labels. For example, when you insert a label tag, the gem
adds the attribute name to a list.

When the form is finished (identified by the submit button), we take
the list of attributes generated while building your form and turn
them into a signed & encrypted string. This is secured using the same
technique as used to store sessions in cookies in Rails. This string
is when included as a hidden field and submitted with the form.

When this arrives back at the server, the string is decoded and
turned back into an array of attributes which should be permitted.

## Installation

Just add the gem to your Gemfile to get started.

```ruby
gem "param-auto-permit", "~> 1.0"
```

## Usage

It's really quite simple to get started.

### Controllers

Whenever you want to permit all the fields for a certain model,
simply use the `:_auto` keyword when you call the `permit` method
in your controllers. For example:

```ruby
params.require(:user).permit(:_auto)
```

You can also add any additional fields which are not included
in the form if you need to.

```ruby
params.require(:user).permit(:_auto, :password, :something_else)
```

### Forms

The gem will identify which fields should be permitted based
on the presence of a label. It also assumes that your submit
button is at the end of your form. Here's an example form:

```erb
<%= form_for @user do |f| %>
  <dl>
    <dt><%= f.label :first_name %></dt>
    <dd><%= f.text_field :first_name %></dd>
    <dt><%= f.label :last_name %></dt>
    <dd><%= f.text_field :last_name %></dd>
  </dl>
  <p><%= f.submit %>
<% end %>
```

If you want to include a label which is not auto permitted,
you can do this:

```erb
<%= f.label :secret_field, :auto_permit => false %>
```

A list of automatically permitted fields will be included
after your submit tag by default (this is why it must be at
the bottom of your form). If you don't wish to include this
you can do this:

```erb
<%= f.submit :include_auto_permit_field => false %>
```

You can then include the field manually in any of your form.

```ruby
<%= f.auto_permitted_attributes_field %>
```
