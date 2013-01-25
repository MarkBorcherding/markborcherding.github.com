---
title: Its all about the plug-ins
layout: post
description: "Something really cool"
category:
tags: [ ]
---
<p>Lets face it. jQuery has made writing JavaScript cool and fun. JavaScript had a bad reputation in my world for a long time, and for no really good reason. JavaScript is an amazing language. Its the crappy compatibility browser implementation of that really sucks. Anyway, Im digressing already.</p>  <p>We write a lot of JavaScript to make the UI snazzy, attractive, quick and easy to use. Im sure we all write a lot of a JavaScript. Im sure we all have tons of JS files sitting around and we include a handful of them on each page, mix and match, pick and choose. What a mess!</p>  <p>Besides the nightmare of having to know which files to include, on which pages, this method is also a performance drag. Each page needs to request 15 to 20 JS files. Sure the page browser is going to cache some of them, but we still pay for the expense in some way or another.</p>  <p>In addition to the performance problem, there is a deployment headache where we have to minify 30 different files. Sure we could script that, but still sounds like a headache.</p>  <p>So how do I have only one JS file (minus the core jQuery stuff I pull from a CDN)? Plug-ins! Every bit of JS I use on my pages is wrapped in a jQuery plug-in. Of course there is a tiny bit of JS that invokes the plug-in that is either directly on the page or in its own JS file, but in comparison of lines, it is statistically insignificant.</p>  <p>What this lets me do is combine every JS file I have into a single giant JS file, minify that, and link it once. Everything I could possibly do is pulled down in that one file, one time, via one request.</p>  <p>Im sure we all have JS like the following.</p>  <pre class="javascript" name="code">$().ready(function(){
  $(&quot;.myButton&quot;).click(function(){
      alert(&quot;You clicked me.&quot;);
      $(&quot;.message&quot;)
           .css(&quot;color&quot;,&quot;blue&quot;)
           .text(&quot;my message is blue&quot;);
  });

});</pre>

<p>Pretty typical jQuery. Everyone likes blue messages. What I don't like about this script is I can't drop it on the page where I don't want that to happen. If it's in my master JS file, every page is going to get this action, and that's probably not what I want. </p>

<p>So let's make a plug-in for it. This is my basic pattern for creating a jQuery plug-in.</p>

<pre class="javascript" name="code">(function($){
  $.fn.messageForm = function(options){
    var defaults = {};
    var params = $.extend(options, defaults);

    // do stuff here

    return this;
  }
})(jQuery);</pre>

<p>There are a lot of websites out there that can explain the pattern better than I can, but the basics are simple. </p>

<p>First, we create an anonymous function with a $ parameter and pass the jQuery object to it. This avoids any naming conflicts we might have with $ and ensures we can use it in our plug-in.</p>

<p>We setup some default values, although empty are at this point, and then merge them with the options that are passed into the call to the plug-in. This lets us easily parameterize the call without adding loads of new variables. </p>

<p>Lastly we return the jQuery object the plug-in was called on so we can allow chaining of other plug-ins.</p>

<p>Throwing in the custom code and we end up with this.</p>

<pre class="javascript" name="code">(function($){
  $.fn.messageForm = function(options){
    var defaults = {
          buttonSelector : &quot;.myButton&quot;,
          messageSelector : &quot;.message&quot;,
          messageColor : &quot;blue&quot;
        };
    var params = $.extend(options, defaults);
    var $this = this;

    function buttonClick(){
       alert(&quot;You clicked me.&quot;);
       $(params.messageSelector,$this)
         .css(&quot;color&quot;,params.messageColor)
         .text(&quot;my message is &quot; + params.messageColor);
    }

    $(params.buttonSelector,$this).click(buttonClick);

    return this;
  }
})(jQuery);</pre>

<p>&#160;</p>

<p>What I can do now is put this JS in a file next to dozens of other similar plug-ins and serve it up. We still have to call it from somewhere though. </p>

<pre class="javascript" name="code">$().ready(function(){
   $(&quot;body&quot;).messageForm();
});</pre>

<p>I know the purists out there would scream, but I dont mind tacking this on the bottom of my HTML. You can pass some parameters to it as well.</p>

<pre class="javascript" name="code">$().ready(function(){
   $(&quot;body&quot;).messageForm({messageColor:&quot;red&quot;});
});</pre>
