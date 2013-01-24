---
title: Testing when ModelState is invalid.
layout: post
description: "Something really cool"
category:
tags: [ ] 
---
{% include JB/setup %}



<p> As a follow up to my previous post, testing when <code>ModelState</code> is relatively simple, but leaves me feelings a little uneasy about my tests.  </p>  <p>Here is an example tests, stripped down to remove some of the unnecessary bits</p>  <pre name="code" class="c#">
public class When_submitting_lead_data_that_is_in_an_invalid_state : Specification
{
    // class fields...etc

    protected override void Given()
    {
        base.Given();
        _mockOrdersRepository = MockRepository.GenerateStub&lt;IOrdersRepository>();
        _checkoutController = new CheckoutController(_mockOrdersRepository);

        _leadDataWithEmptyPlanName = new PreCheckoutViewData();

        // add an error to the model state
        _checkoutController.ModelState.AddModelError("", "");
        
        _exceptionWasThrown = false;
    }

    protected override void When()
    {
        base.When();
        try
        {
            _checkoutController.Checkout(_leadDataWithEmptyPlanName);
        } catch(ArgumentNullException)
        {
            _exceptionWasThrown = true;
        }
    }

    [Then] public void an_exception_is_thrown()
    {
        _exceptionWasThrown.ShouldBe(true);
    }
}
</pre>

<p>
  This feels pretty loose to me, but there can be another tests that tests which states the model will appear invalid.
</p>
