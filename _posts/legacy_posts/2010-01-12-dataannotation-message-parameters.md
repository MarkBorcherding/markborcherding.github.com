---
title: DataAnnotation Message Parameters
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p>Im adding custom validation messages to all my data annotation validation attributes. Simple stuff right. I started off with this.</p>  <p><script src="http://gist.github.com/275449.js?file=NoMessage.cs"></script></p>  <p>Then added a customer message.</p>  <p><script src="http://gist.github.com/275449.js?file=CustomMessage.cs"></script></p>  <p>Then moved that message to a resource file</p>  <p><script src="http://gist.github.com/275449.js?file=ResourceMessage.cs"></script></p>  <p>The problem is the resource file says something like Less than 50. If I change that 50 on the attribute, someone has to remember to go to the resource file and change it there too. Not very DRY. </p>  <p>Luckily the default message formatting will allow us to embed some tokens in the error message.&#160; All we need to do is change our message to <strong>Less than {1}</strong> and the message is formatted to Less than 50.or whatever the argument value might be.</p>  <p>I haven't found a good list of the parameters you pass, but {0} is the property name, and then I assume 1, 2, 3, etc are the parameters of the constructor in order.</p>
