---
layout: post
title: "Angular mocks via Mocha"
description: ""
category:
tags: []
---

Yeoman has been great so far. So has Angular. I’m really enjoying working with both. One of the headache is Yeoman brakes from Angular’s
convention of using Jasmine + Testacular and replaces it with Mocha. I don’t really have information to make an opinion of either, but
Mocha has served me well up to testing the Angular stuff, so I decided to stick with that, but there was a few gotchas a long the way.

## Upgrade to 1.1.x

Up until that point I was using the Angular Stable that comes with yeoman install angular. In order to get Mocha to work, you’ll need to upgrade to the unstable branch.

## Include angular-mocks

You’ll need to include angular-mocks.js somewhere. I added it to test/lib and included it right before my spec files in test/index.html

{% highlight html %}
<script src="lib/angular-mocks.js"></script>
{% endhighlight %}

# Tweak angular-mocks

After the first two steps, you’d think it would work. So did I, but it didn’t I got the following error.

    Running "mocha:all" (mocha) task
    Testing index.htmlF
    >> HomeController - true is true
    >> Message: 'undefined' is not an object (evaluating 'currentSpec.queue.running')

    <WARN> 1/2 assertions failed (0s) Use --force to continue. </WARN>

    Aborted due to warnings.

After a ton of Googling, I found a [Google Group Message](https://groups.google.com/forum/#!msg/socketstream/jDDCkQJpsDM/lQgxQftFwHsJ)
with the same problem. Their solution, tweak the angular-mocks.js just a bit.

{% highlight javascript %}
function isSpecRunning() {
    return currentSpec && currentSpec.queue && currentSpec.queue.running
        || currentSpec; // for Mocha.
}
{% endhighlight %}

Now everything works…for now.

    Running "mocha:all" (mocha) task
    Testing index.html..OK
    >> 2 assertions passed (0s)

    Done, without errors.

I may eventually switch back to testacular, but we’ll see how far we can go with this setup.
