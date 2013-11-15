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
        
Notice how the syntax makes it very clear what this association is all about. Pretty cool! Then, the padawan.rb model file:

        class Padawan < ActiveRecord::Base
          attr_accessible :name
          has_many :apprenticeships
          has_many :jedis, :through => :apprenticeships
        end
				
And, finally, set up the apprenticeships.rb model file like this:

        class Apprenticeship < ActiveRecord::Base
          attr_accessible :jedi_id, :padawan_id
          belongs_to :jedi
          belongs_to :padawan
        end

We're almost ready to take a look at the app. Just a couple of steps before we fire it up in our browser. Delete the public/index.html file first. Then, we want the apprenticeships index page to be the root of our app, so open up config/routes.rb and add this line somewhere (toward the top is nice):

        root :to => 'apprenticeships#index'
        
Then, start the local server in sithfighter's main directory:

        $ rails s
        
Open your browser, and go to the address http://localhost:3000. This is what you should see:

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image1.png)

Cool! Could it be that easy? Well, almost. If we click "New Apprenticeship", we get this:

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image2.png)

(It may look a little different, depending on your browser.) You'll notice that you're only allowed to enter numbers, though, which isn't exactly what we want.

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image3.png)

Click on "Create Apprenticeship" and you indeed create an apprenticeship, but with useless numbers...

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image4.png)

Those numbers are Jedi and Padawan ID's, though none have been created yet. What we need are a bunch of Jedi and Padawan names. Let's put some links in to create some Jedis and Padawans. We need to head over to the views and do some work there. First up, app/views/apprenticeships/index.html.erb. Add the following link code to the bottom of that file:

        <%= link_to 'New Jedi', new_jedi_path %>
        <%= link_to 'New Padawan', new_padawan_path %>
        
Take a look, reload http://localhost:3000 and we should see:

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image5.png)

Ah ha, now we can start making some Jedis and Padawans! First, let's make a bunch of Jedis:

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image6.png)

And then, create a slew of Padawans, all eager to become powerful Jedis (go back to http://localhost:3000 to get to the "New Padawan" link):

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image7.png)

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

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image8.png)

Create an apprenticeship, and let’s see what happens…

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image9.png)

Hmm, we’re almost there, but we’re only seeing the Jedi and Padawan ID’s in the apprenticeship show view. Not very satisfying. Let’s change that so we can see their names.

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

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image10.png)

Much better! But, clicking “Back” to get back to the Apprenticeships index, we see those darn ID’s again.

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image11.png)

To change that, let’s change the appropriate views/apprenticeships/index.html.erb lines to read from this:

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

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image12.png)

That’s what we want to see! Make a few more associations, and we can see all the Apprenticeships we need:

![](https://s3-us-west-2.amazonaws.com/portmls/portfolio/image13.png)

There you go, a step-by-step tutorial on how to make has_many :through associations AND a refresher on Jedi/Padawan apprenticeships in the Star Wars universe. I hope it has helped you avoid some of the confusion I went through when I first was learning this particular association. I know I wasn't the only one making life harder than it needed to be. I learned to let go a little bit and just let Ruby on Rails do some of its magic for us. so cool.

Find all the code for the “sithfighters” tutorial project on GitHub:
https://github.com/mlsayre/sithfighters

Matt Sayre's blog found at:
http://gitmatt.com
