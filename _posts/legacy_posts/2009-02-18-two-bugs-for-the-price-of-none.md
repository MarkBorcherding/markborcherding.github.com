---
title: Two bugs for the price of none
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



We recently pushed a feature into production that had a pretty serious flaw. If gone unfound it could have caused headaches with billing the wrong customer the wrong amount and all kinds of other potentially damning effects.  Luckily for us, we also had a second bug. The feature that was to send the notification e-mail that data was ready to be corrupted by our bug was misconfigured when it moved to the production environment. Lucky for us, no one was being told they should go execute our buggy code, so no one did and we found it, fixed it and all those actions items that queued up ran through without a hitch.

Now lucky for us or not, we did fail to find two serious bugs. It highlights the need for thorough acceptance testing. <em>Thorough</em> being the key word there.

The first bug existed if action items queued up and were acted upon in a certain order. Testing was done in this area, but the items never fell in the order where we found the bug. Would acceptance tests go so far to say:
<ul>
	<li>Act on the first item in the list and verify the actions were taken correctly.</li>
	<li>Act on the second item in the list...</li>
	<li>Act on a list with a single item...</li>
	<li>Act on a list with two items...</li>
	<li>Act on a list with <em>n</em> items...</li>
</ul>
How detailed do you get?

The first bug was a pretty lame mistake, although I feel SQL should have been alerted when we attempted to do an udate a single from a statement that returned multiples. I don't know how it makes sense to choose the first row and go about your business.

As for the second, testing the production configuration is hard. We do have some junk data laying around in the production DB that we can manipulate, and probably should have to verify the e-mails were sending. Config changes between the two are difficult to manage. Keeping the e-mail address, servers, roles, etc in sync to the correct environment is made simpler by branches, but verification isn't.
