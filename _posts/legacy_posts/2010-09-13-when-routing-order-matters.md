---
title: When Routing Order Matters
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}

I'm taking my first real steps into Rails with a pet project. It's exciting and fun and I make a lot of wrong steps along the way. The most recent revolves around routing. Here's a brief bit. I have two models, breweries and beers. (We side project what we love right?) Breweries have many beers, but beers can be viewed on their own. At first, I had my routes laid out like this:

    :::ruby
    resources :beers
    resources :breweries do
      resources :beers
    end

That all works well. I can route to `/beers/1/beers` and `/beers`. The only problem is the views for beer create links that always go back to the initial `/beers` route. The new, show, edit, etc. all break out of the route that includes the brewery id. The obvious fix is to just do this in the view.

    :::ruby
    <%= link_to 'new' , ( params[:brewery_id].nil? ? new_brewery_beer_path : new_beer_path ) %>

That is pretty lame though right? Shouldn't we maybe move that to the helper?

    :::ruby
	def via_brewery?
      !params[:brewery_id].nil?
    end
    
    def new_path
      if via_brewery? 
        return new_brewery_beer_path(:brewery_id => params[:brewery_id]) 
      else
        return new_beer_path
      end
    end

Better. Not super lame, but still messy. We still need functions for each type of route and that doesn't feel very DRY. So what to do.

I thought it might be finding that `/beers` route because it appears first, and maybe if I change that order, things might work better. 

    :::ruby
    resources :breweries do
      resources :beers
    end
    resources :beers

Well you know what? It does work! It looks through those routes in order. When you're visiting via the `/beers` route, you don't have a `:brewery_id` so that first route gets skipped, and we get the second. When we have the id, we get the first route. Now we have a much simpler view.

    :::ruby
    <%= link_to 'new', :controller => :beers, :action => :new %>

Much much better! The more I use Ruby and Rails, but more I love it. Something like that in .Net would have been much more difficult.
