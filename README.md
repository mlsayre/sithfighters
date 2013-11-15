has_many :through Tutorial "sithfighters"
=========================================

The has_many :through association is one of the most useful associations in Rails. It is a way of relating two models together *through* another model. For instance, a mentor may have many mentees and a mentee may have many mentors, all linked together through mentorships. The three models there would be mentors, mentees, and mentorships. Or doctors may have many patients and patients may have many doctors and they could all be linked together through their appointments. 

Rails makes creating these associations very easy, but it's also easy to overthink these relationships. If you just let Rails perform its magic, though, you can really see one of the strength of the Ruby on Rails framework. The first time I tried to make a has_many :through association, I overthought it and spent many hours trying to figure out what would later take me only about 20 minutes.

This tutorial is meant to help a Rails beginner create and understant this association and see how easy Rails can make your life! Has_many :through is just one of many model associations, but can be somewhat confusing if you're not clear on the concept. I will take you step-by-step through the process of creating the association, starting with creating a new Rails project.

I used Rails version 3.2.14 with Ruby version 2.0.0p247. Follow along as we associate Jedis to Padawans through "Apprenticeships". If you're not familiar with Star Wars (?!), Jedis are like teachers and Padawans are like students. (And go now to watch Star Wars Episodes 4-6. This tutorial will be here when you get back.)

In a galaxy...
==============
First step, create our new project, called "sithfighters". We don't need the test framework, so we'll leave that out of our project.

        $ rails new sithfighters --skip-test-unit

Next, we will create the three models we need for our has_many :through association. To make our lives easier, we'll use scaffolding in order to create the associated views and controllers at the same time.

        $ rails g scaffold jedi name:string --skip-test-framework
        $ rails g scaffold padawan name:string --skip-test-framework
        $ rails g scaffold apprenticeship jedi_id:integer padawan_id:integer --skip-test-framework
        
With our new models, we need to run the migrations to create the necessary tables in our database, so:

        $ rake db:migrate
        
And now let's make the associations. This is done in the model files. First up, jedi.rb (in app/models directory) should look like this:

        class Jedi < ActiveRecord::Base
          attr_accessible :name
          has_many :apprenticeships
          has_many :padawans, :through => :apprenticeships
        end

4. Set up associations in model files
	- jedi.rb:
class Jedi < ActiveRecord::Base
  attr_accessible :name
  has_many :apprenticeships
  has_many :padawans, :through => :apprenticeships
end
	- padawan.rb:
class Padawan < ActiveRecord::Base
  attr_accessible :name
  has_many :apprenticeships
  has_many :jedis, :through => :apprenticeships
end
	- apprenticeship.rb
class Apprenticeship < ActiveRecord::Base
  attr_accessible :jedi_id, :padawan_id
  belongs_to :jedi
  belongs_to :padawan
end

5. Look at what we have so far
	- delete public/index.html file
	- We want to see apprenticeships so set root page to that. In routes file (config/routes.rb), add:
root :to => 'apprenticeships#index'
	- start local server in project’s main directory: 
$ rails s
	- open browser, go to http://localhost:3000
IMAGE1.png
	- click “New Apprenticeship”.
IMAGE2.png
- Only numbers (Jedi and Padawan ID’s work. 
IMAGE3.png
Click “Create Apprenticeship”
IMAGE4.png
We need to make it more user-friendly. These numbers are the Jedi and Padawan ID’s, yet those Jedis and Padawans don’t exist yet! Let’s create some Jedis and Padawans.

6. Editing the views to make it easy to create Apprenticeships. First, in views/apprenticeships/index.html.erb, add at the very end:

<%= link_to 'New Jedi', new_jedi_path %>
<%= link_to 'New Padawan', new_padawan_path %>

Take a look, reload http://localhost:3000 in browser:
	IMAGE5.png
Now we can easily create Jedis and Padawans! Let’s create some.
Jedis: IMAGE6.png
(simply go back to http://localhost:3000 to start creating Padawans)
Padawans: IMAGE7.png

Now we need to make it easy to pair the Jedis and Padawans up through apprenticeships, so let’s use their names rather than their ID’s through drop down menus. That code is found in the Apprenticeships _form.html.erb partial. Let’s change the end of that file from this:

  <div class="field">
	<%= f.label :jedi_id %><br />
	<%= f.number_field :jedi_id %>
  </div>
  <div class="field">
	<%= f.label :padawan_id %><br />
	<%= f.number_field :padawan_id %>
  </div>
  <div class="actions">
	<%= f.submit %>
  </div>
<% end %>

to this:
<div class="field">
	<%= f.select :jedi_id, Jedi.all.collect { |p| [ p.name, p.id ] } %>
  </div>
  <div class="field">
	<%= f.select :padawan_id, Padawan.all.collect { |p| [ p.name, p.id ] } %>
  </div>
  <div class="actions">
	<%= f.submit %>
  </div>
<% end %>

Now we have drop down menus, populated with all of our Jedis and Padawans, all ready to be synched up through their Apprenticeships!

IMAGE8.png

Create an apprenticeship, and let’s see what happens…

IMAGE9.png

Hmm, we’re almost there, but we’re only seeing the Jedi and Padawan ID’s in the apprenticeship show view. Not very satisfying Let’s change that so we can see their names.

In views/apprenticeships/show.html.erb, change these lines:

<p>
  <b>Jedi:</b>
  <%= @apprenticeship.jedi_id %>
</p>

<p>
  <b>Padawan:</b>
  <%= @apprenticeship.padawan_id %>
</p>

to read like this:

<p>
  <b>Jedi:</b>
  <%= @apprenticeship.jedi.name %>
</p>

<p>
  <b>Padawan:</b>
  <%= @apprenticeship.padawan.name %>
</p>

And reload…
IMAGE10.png

Much better! But, clicking “Back” to get back to the Apprenticeships index, we see those darn ID’s again.

IMAGE11.png

Let’s change the appropriate views/apprenticeships/index.html.erb lines to read from this:

<% @apprenticeships.each do |apprenticeship| %>
  <tr>
	<td><%= apprenticeship.jedi_id %></td>
	<td><%= apprenticeship.padawan_id %></td>

to this:

<% @apprenticeships.each do |apprenticeship| %>
  <tr>
	<td><%= apprenticeship.jedi.name %></td>
	<td><%= apprenticeship.padawan.name %></td>

And reloading the apprenticeships index, we see:
IMAGE12.png

That’s what we want to see! Make a few more associations, and we can see all the Apprenticeships we need:

IMAGE13.png

There you go, a step-by-step tutorial on how to make has_many :through associations AND a refresher on Jedi/Padawan apprenticeships in the Star Wars universe. 

Find all the code for the “sithfighters” tutorial project on GitHub:
https://github.com/mlsayre/sithfighters
